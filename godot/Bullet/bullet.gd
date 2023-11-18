extends Area2D
var damage
var speed = 20
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_movement(direction)
	pass

func _movement(dir):
	position += dir * speed
	pass

func _on_body_entered(body):
	print("Hit something")
	if(body.is_in_group("players")):
		queue_free()
		pass
	elif(body.is_in_group("enemies")):
		body.take_damage(damage)
		queue_free()
	else:
		pass
	
