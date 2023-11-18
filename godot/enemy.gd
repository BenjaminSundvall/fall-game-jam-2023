extends CharacterBody2D

var player
var attack
var speed = 400
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player")
	attack = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (attack):
		var player_coord = player.get_position()
		var self_coord = get_parent().get_position()
		var direction = (player_coord-self_coord).normalized()
		velocity = direction * speed
		move_and_slide()
	pass

func _die():
	#Potential animations etc for dying
	self.queue_free()
	pass
	
func start_attacking():
	attack = true
	pass
	
func take_damage(damage):
	health += damage
	if health <= 0:
		self._die()
	pass
