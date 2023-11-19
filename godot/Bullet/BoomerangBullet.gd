extends Bullet

var player_who_shot
var on_player
var min_lifetime
var had_enough = 2
var angular_velocity = 0.2
var velocity_vector
var acceleration = 1
var acceleration_vector
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	lifetime = 0
	speed = 10

func _update_physics(delta):
	_movement(direction)
	lifetime += delta
	if(lifetime >= min_lifetime and on_player):
		queue_free()
	if(lifetime >= had_enough):
		velocity_vector = (player_who_shot.global_position - global_position).normalized() * 50
		pass
	acceleration_vector = (player_who_shot.global_position - global_position).normalized() * acceleration
	velocity_vector += acceleration_vector
	_movement(direction)
	
	

func _movement(dir):
	position += velocity_vector
	rotation += angular_velocity 
	#rotation = dir.angle()

func _on_body_entered(body):
	if(body.is_in_group(enemy)):
		body.take_damage(damage)
	if(body == player_who_shot):
		on_player = true
		
func _on_body_exited(body):
	if(body == player_who_shot):
		on_player = false
