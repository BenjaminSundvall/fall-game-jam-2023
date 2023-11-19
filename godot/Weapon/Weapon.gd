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
	pass

func _attack(direction):
	pass

func attack_pressed(direction):
	pass

func attack_released(direction):
	pass

	
func _get_enemy():
	if get_parent().is_in_group("players"):
		return "enemies"
	elif get_parent().is_in_group("enemies"):
		return "players"
	else:
		return ""
