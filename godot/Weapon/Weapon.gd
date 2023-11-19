extends Node2D
class_name Weapon

@export var bullet_damage:int
@export var Bullet:PackedScene
var weapon_vector


# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_vector = Vector2.RIGHT
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		_update_physics(delta)

@rpc("authority", "call_local")
func attack(direction):
	pass
	
# To be overwritten
func _update_physics(delta):
	pass
	
func spawn_bullet(bullet):
	bullet.name = "Bullet"
	get_tree().get_first_node_in_group("Map").add_child(bullet, true)
	
func _get_enemy():
	if get_parent().is_in_group("players"):
		return "enemies"
	elif get_parent().is_in_group("enemies"):
		return "players"
	else:
		return ""
