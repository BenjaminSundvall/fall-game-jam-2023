extends Bullet
var distance = 500
var height = 250
var time

var elapsed_time = 0
var progress = 0
var start_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 300
	time = distance/speed
	pass # Replace with function body.

#height*(x-start_pos)(x-(start_pos+dir*distance))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if elapsed_time == 0:
		start_pos = self.global_position
		
	elapsed_time += delta
	progress = elapsed_time/time
	var height = _travel_height()
	var dir = _travel_dir()
	global_position = start_pos + height + dir 
	
	if progress >= 1:
		queue_free()
	
	pass
	
func _travel_height():
	var x = progress*distance*direction.x
	var a = 0
	var b = direction.x*distance
	
	return Vector2(x, -height*_parabola(x,a,b)/_parabola((a+b)/2,a,b))
	pass
	
func _parabola(x,a,b):
	return((x)**2 - ((a+b)*x) + (a*b))

func _travel_dir():
	return direction*progress*distance
	pass

