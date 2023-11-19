extends Node

var spawners = []

# Called when the node enters the scene tree for the first time.
func _ready():
	spawners = get_tree().get_nodes_in_group("spawners")
	var enemy_prefab = preload('res://Enemy/Enemy.tscn')
	var enemy_weapon = preload('res://Weapon/Pistol.tscn')
	spawn_enemies(enemy_prefab, enemy_weapon)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().call_group("enemies", "start_attacking")
	pass

func spawn_enemies(enemy_prefab, weapon_prefab):
	for spawner in spawners:
		var coordinate = spawner.get_position()
		var enemy = enemy_prefab.instantiate()
		var weapon = weapon_prefab.instantiate()
		
		enemy.add_to_group("enemies")
		enemy.position = coordinate
		
		enemy.add_child(weapon)
		add_sibling.call_deferred(enemy)
