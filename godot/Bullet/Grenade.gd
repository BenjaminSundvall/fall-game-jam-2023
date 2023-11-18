extends Bullet
var distance = 40
var height = 30
var time = distance/speed

var elapsed_time = 0
var progress = 0
var start_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 20
	start_pos = global_position
	pass # Replace with function body.

#height*(x-start_pos)(x-(start_pos+dir*distance))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time += delta
	progress = elapsed_time/time
	
	var height = _travel_height()
	var dir = _travel_height()
	global_position = start_pos + height + dir 
	pass
	
func _travel_height():
	var x = progress*distance
	var a = start_pos
	var b = start_pos*direction[1]*distance
	
	return (x)**2 - ((a+b)*x) + (a*b)
	pass

func _travel_dir():
	var x = progress*distance
	return direction*x
	pass

