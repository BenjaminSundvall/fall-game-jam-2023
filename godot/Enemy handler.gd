extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_prefab = preload('res://enemy.tscn')
	var spawners = get_tree().get_nodes_in_group("spawners")
	
	for spawner in spawners:
		var coordinate = spawner.get_position()
		var enemy = enemy_prefab.instantiate()
		
		enemy.add_to_group("enemies")
		enemy.position = coordinate
		
		add_child(enemy)
	
	get_tree().call_group("enemies", "start_attacking")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
