extends Weapon

var dangerZone = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func attack(direction):
	for i in range(dangerZone.size()):
		dangerZone[i].take_damage(1)
	

func _on_body_entered(body):
	if(body.is_in_group("enemies")):
		dangerZone.add(body)
	

func _on_body_exited(body):
	if(body.is_in_group("enemies")):
		dangerZone.remove(body)
	
	
