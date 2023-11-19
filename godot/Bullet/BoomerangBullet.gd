extends Bullet

var player_who_shot
var on_player
var min_lifetime
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	lifetime = 0
	speed = 5


func _process(delta):
	_movement(direction)
	lifetime += delta
	if(lifetime >= min_lifetime and on_player):
		queue_free()

func _movement(dir):
	position += dir * speed
	#rotation = dir.angle()


func _on_body_entered(body):
	if(body.is_in_group(enemy)):
		body.take_damage(damage)
	if(body == player_who_shot):
		on_player = true
		
func _on_body_exited(body):
	if(body == player_who_shot):
		on_player = false
