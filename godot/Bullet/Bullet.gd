extends Area2D
class_name Bullet
var damage
var speed
var direction
var enemy
var max_lifetime
var lifetime



# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _movement(dir):
	pass

func _on_body_entered(body):
	pass
		
	
