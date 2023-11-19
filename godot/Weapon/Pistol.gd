extends Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if multiplayer.get_unique_id() == get_multiplayer_authority():
		_physics_update(delta)
	
# Overriden in subclasses
func _physics_update(delta):
	pass

func attack(direction):
	var enemy = _get_enemy()
	var bullet = Bullet.instantiate()

	bullet.enemy = enemy
	bullet.global_position = self.global_position
	bullet.direction = direction.normalized()
	bullet.damage = bullet_damage

	spawn_bullet(bullet)
