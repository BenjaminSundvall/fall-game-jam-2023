extends Weapon


var enemy
var holding = true
var min_lifetime = 0.2
var current_dir
var parent
# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_damage = 50
	parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = weapon_vector.angle()
	pass

func attack(direction):
	if(holding):
		holding = false
		var enemy = _get_enemy()
		var bullet = Bullet.instantiate()

		bullet.enemy = enemy
		bullet.global_position = global_position
		bullet.direction = direction.normalized()
		bullet.damage = bullet_damage

		spawn_bullet(bullet)
	
	
