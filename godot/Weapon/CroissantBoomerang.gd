extends Weapon


var enemy
var holding = true
var collisionShape
var min_lifetime = 0.2
var lifetime = 0
var currently_on_parent = true
var speed = 1
var current_dir
# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_damage = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = weapon_vector.angle()
	if(lifetime >= min_lifetime and currently_on_parent and not holding):
		print("return to papa")
		holding = true
		pass
	pass

func attack(direction):
	if(holding):
		holding = false
		var enemy = _get_enemy()
		var bullet = Bullet.instantiate()
		get_node("/root").add_child(bullet)
		bullet.enemy = enemy
		bullet.global_position = global_position
		bullet.direction = direction.normalized()
		bullet.damage = bullet_damage

	pass

	

func _on_body_entered(body):
	if(body.is_in_group(enemy)):
		body.take_damage(50)
	if(body == get_parent()):
		currently_on_parent = true

	

func _on_body_exited(body):
		if(body.is_in_group(enemy)):
			pass
		if(body == get_parent()):
			currently_on_parent = false

	
	
