extends Node2D
class_name Weapon

@export var bullet_damage:int
@export var Bullet:PackedScene
var weapon_vector

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(direction):
	pass
	
func _get_enemy():
	if get_parent().is_in_group("players"):
		return "enemies"
	elif get_parent().is_in_group("enemies"):
		return "players"
	else:
		return ""
