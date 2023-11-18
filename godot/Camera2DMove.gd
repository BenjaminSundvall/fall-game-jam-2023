extends Camera2D

var SPEED = 20;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movebool = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	var velocity = movebool * SPEED
	position.x += velocity[0]
	position.y += velocity[1]
	
	
