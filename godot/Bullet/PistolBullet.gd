extends Bullet


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	speed = 20

func _update_physics(delta):
	_movement(direction)

func _movement(dir):
	position += dir * speed
	rotation = direction.rotated(PI/2).angle()

func _on_body_entered(body):
	if(body.is_in_group(enemy)):
		body.take_damage(damage)
		queue_free()
	elif(body.is_in_group("bullet_collider")):
		queue_free()
	else:
		pass
		
	
