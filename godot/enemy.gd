extends CharacterBody2D

var player
var attack
var speed = 400
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../Player" # TODO: Make not direct
	print_debug(player)
	attack = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (attack):	
		_walking(player.position)
		
func _walking(to_where):
	var direction = (to_where-position).normalized()
	velocity = direction * speed
	move_and_slide()

func _die():
	#Potential animations etc for dying
	self.queue_free()
	
# Public beahviour call
func start_attacking():
	print_debug("True")
	attack = true
	
func take_damage(damage):
	health += damage
	if health <= 0:
		self._die()
