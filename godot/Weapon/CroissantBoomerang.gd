extends Weapon


var enemy
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Area2D").connect("body_entered", _on_body_entered)
	get_node("Area2D").connect("body_exited", _on_body_exited)
	enemy = _get_enemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func attack(direction):
	pass

	

func _on_body_entered(body):
	if(body.is_in_group(enemy)):
		body.take_damage(50)

	

func _on_body_exited(body):
		if(body.is_in_group(enemy)):
			pass

	
	
