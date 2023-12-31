extends Bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	lifetime = 0
	pass # Replace with function body.


func _process(delta):
	_movement(direction)
	lifetime += delta
	if(lifetime >= max_lifetime):
		queue_free()
	pass

func _movement(dir):
	position += dir * speed
	rotation = dir.angle()
	pass

func _on_body_entered(body):
	if(body.is_in_group(enemy)):
		body.take_damage(damage)
		queue_free()
	elif(body.is_in_group("bullet_collider")):
		queue_free()
	else:
		pass
