extends Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if weapon_vector:
		rotation = weapon_vector.rotated(PI/2).angle()

func attack_pressed(direction):
	_attack(direction)

func _attack(direction):
	var enemy = _get_enemy()
	var bullet = Bullet.instantiate()
	get_node("/root").add_child(bullet)
	bullet.enemy = enemy
	bullet.global_position = self.global_position
	bullet.direction = direction.normalized()
	bullet.damage = bullet_damage

