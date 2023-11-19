extends Node

var spawners = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var spawners = get_tree().get_nodes_in_group("spawners")
	
	spawn_enemies('res://Enemy/Enemy.tscn', 'res://Weapon/Pistol.tscn')
	get_tree().call_group("enemies", "start_attacking")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func spawn_enemies(enemy_path, weapon_path):
	var enemy_prefab = preload(enemy_path)
	var enemy_weapon = preload(weapon_path)
	
	for spawner in spawners:
		var coordinate = spawner.get_position()
		var enemy = enemy_prefab.instantiate()
		var weapon = enemy_weapon.instantiate()
		
		enemy.add_to_group("enemies")
		enemy.position = coordinate
		
		enemy.add_child(weapon)
		add_child(enemy)
