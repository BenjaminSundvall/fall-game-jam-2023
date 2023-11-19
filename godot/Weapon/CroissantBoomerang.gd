extends Weapon


var enemy
var holding = true
var min_lifetime = 0.4
var current_dir
var parent
var boolet
var boomerang_speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_damage = 50
	parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = weapon_vector.angle()
	if(boolet == null):
		holding = true
		get_node("Sprite2D").visible = true
	pass

func attack(direction):
	if(holding):
		holding = false
		var enemy = _get_enemy()
		var bullet = Bullet.instantiate()
		get_node("/root").add_child(bullet)
		boolet = bullet
		bullet.enemy = enemy
		bullet.global_position = global_position
		bullet.direction = direction.normalized()
		bullet.damage = bullet_damage
		bullet.player_who_shot = parent
		bullet.min_lifetime = min_lifetime
		bullet.velocity_vector = direction.normalized() * boomerang_speed
		get_node("Sprite2D").visible = false
		

	
	
