extends Weapon

var dangerZone = []
var enemy
var animationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Area2D").connect("body_entered", _on_body_entered)
	get_node("Area2D").connect("body_exited", _on_body_exited)
	animationPlayer = get_node("AnimationPlayer")
	enemy = _get_enemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func attack(direction):
	animationPlayer.play()
	for i in range(dangerZone.size()):
		dangerZone[i].take_damage(40)
	

func _on_body_entered(body):
	if(body.is_in_group(enemy)):
		dangerZone.append(body)
	

func _on_body_exited(body):
		if(body.is_in_group(enemy)):
			dangerZone.erase(body)
	
	
