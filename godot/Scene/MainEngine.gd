extends Node2D

@export var scene : PackedScene
@export var player : PackedScene

@export var weapons : Array[PackedScene]

const SPAWN_DIST = 200

var players = []


# Called when the node enters the scene tree for the first time.
func _ready():
	set_multiplayer_authority(multiplayer.get_unique_id())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func start_offline_game():
	#print_debug("Offline?! You don't have friends?")
	_switch_to_scene.rpc()
	var player = _initiate_player("Player", 0)
	player.load(1, Vector2.ZERO, "Player", false)
	
func start_online_game():
	#print_debug("I will try!")
	_switch_to_scene.rpc()
	var network_manager = $"NetWork ManAnger"
	var players_to_initiate = network_manager.connected_players
	
	var some_pos = Vector2(SPAWN_DIST, 0)
	
	for player_id in players_to_initiate:
		var player_name = network_manager.connected_players[player_id]
		var player = _initiate_player(player_name)
		some_pos = some_pos.rotated(2*PI/len(players_to_initiate))
		player.load.rpc(player_id, some_pos, player_name, true)	
		
func _initiate_weapon(i=-1):
	var weapon_to_initiate
	if 0 <= i and i < len(weapons):
		weapon_to_initiate = i
	else:
		weapon_to_initiate = randi() % len(weapons)
	
	return weapons[weapon_to_initiate]
	
func _initiate_player(name, weapon_i=-1):
	var player = self.player.instantiate()

	player.name = name
	get_tree().get_nodes_in_group("Map")[0].add_child(player)	
	players.append(player)

	player.add_weapon(_initiate_weapon(weapon_i))
	
	return player


# Everyone will manage their own change of scene
@rpc("reliable", "call_local")
func _switch_to_scene():
	
	var top_scene = $Scene
	
	var menu = top_scene.get_node("Control")
	top_scene.remove_child(menu)
	menu.queue_free()
	
	var real_scene = scene.instantiate()
	add_child(real_scene)

