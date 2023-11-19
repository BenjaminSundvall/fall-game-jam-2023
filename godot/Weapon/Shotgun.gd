extends Weapon



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if weapon_vector:
		rotation = weapon_vector.rotated(PI/2).angle()

var bullet_speed = 30
var pellets = 5
var damage_per_pellet = 5
var spread = 30 #degrees
var pellet_max_lifetime = 0.3 


func attack(direction):
	var enemy = _get_enemy()
	for i in range(pellets):
		var bullet = Bullet.instantiate()
		var angle = (randf()*spread - spread/2)*PI/180#radians
		var new_dir = direction.rotated(angle)
		get_node("/root").add_child(bullet)
		bullet.max_lifetime = pellet_max_lifetime
		bullet.speed = bullet_speed
		bullet.enemy = enemy
		bullet.global_position = global_position
		bullet.direction = new_dir.normalized()
		bullet.damage = damage_per_pellet
