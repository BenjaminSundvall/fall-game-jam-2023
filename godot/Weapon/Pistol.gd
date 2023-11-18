extends Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(direction):
	var friendly = get_allegiance()
	var bullet = Bullet.instantiate()
	get_node("/root").add_child(bullet)
	bullet.friendly = friendly
	bullet.global_position = global_position
	bullet.direction = direction.normalized()
	bullet.damage = bullet_damage
	
func get_allegiance():
	if get_parent().is_in_group("players"):
		return "players"
	elif get_parent().is_in_group("enemies"):
		return "enemies"
	else:
		return ""
