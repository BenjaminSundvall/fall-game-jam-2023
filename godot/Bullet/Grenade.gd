extends Bullet
var distance = 500
var height = 250
var time

var elapsed_time = 0
var progress = 0
var explode_progress = 0
var start_pos

var exploded = false
var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 300
	time = distance/speed
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	get_node("Area2D").connect("body_entered", _on_inner_entered)
	pass # Replace with function body.

#height*(x-start_pos)(x-(start_pos+dir*distance))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if elapsed_time == 0:
		get_node("AnimatedSprite2D").play("flying")
		if direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = true
			
		start_pos = self.global_position
		
	elapsed_time += delta
	progress = elapsed_time/time
	
	if exploded:
		if progress-explode_progress >= 0.5:
			queue_free()
		return
		
	if progress >= 1:
		_explode()
		return
		
	var height = _travel_height()
	var dir = _travel_dir()
	global_position = start_pos + dir
	$AnimatedSprite2D.position = height 
	
func _on_inner_entered(body):
	if body.is_in_group("bullet_collider"):
		_explode()

func _deal_damage():
	for hostile in enemies:
		hostile.take_damage(damage)
	
func _on_body_entered(body):
	if body.is_in_group(enemy):
		enemies.append(body)

func _on_body_exited(body):
	if body.is_in_group(enemy):
		enemies.erase(body)
	
func _travel_height():
	var x = progress*distance*direction.x
	var a = 0
	var b = direction.x*distance
	
	return Vector2(0, -height*_parabola(x,a,b)/_parabola((a+b)/2,a,b))
	
func _parabola(x,a,b):
	return((x)**2 - ((a+b)*x) + (a*b))

func _explode():
	get_node("AnimatedSprite2D").play("explode")
	$AnimatedSprite2D.scale *= 2
	$Sprite2D.visible = false
	exploded = true
	explode_progress = progress
	_deal_damage()

func _travel_dir():
	return direction*progress*distance

