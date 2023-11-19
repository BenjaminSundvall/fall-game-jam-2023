extends Bullet

var player_who_shot
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	lifetime = 0
	speed = 10


func _process(delta):
	_movement(direction)
	lifetime += delta

func _movement(dir):
	position += dir * speed
	#rotation = dir.angle()


func _on_body_entered(body):
	if(body.is_in_group(enemy)):
		body.take_damage(damage)
