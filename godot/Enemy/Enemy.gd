extends CharacterBody2D

var attack = false
var speed = 400
var health = 100
var weapon
var attacktime = 1000
var last_time = 0

# Called when the node enters the scene tree for the first time.
func _ready(): # TODO: Make not direct
	#print_debug(player)
	attack = false
	weapon = get_node("Weapon")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var players = get_node("/root/MainScene").players
	var shoot = false
	var cur_time = Time.get_ticks_msec()
	if (cur_time - last_time > attacktime):
		shoot = true
		last_time = cur_time
		
	Time.get_ticks_msec()
	if (!attack):
		return
		
	if players.size() == 0:
		return
	
	var closest_player = players[0]
	var shortest_dist = players[0].global_position - global_position 
	for player in players:
		var dist = player.global_position-global_position
		if dist < shortest_dist:
			shortest_dist = dist
			closest_player = player
	
	_walking(closest_player.position)
	if shoot:
		_attack(closest_player.position)
		
func _walking(to_where):
	var direction = (to_where-position).normalized()
	velocity = direction * speed
	move_and_slide()

func _attack(to_where):
	var direction = (to_where-position).normalized()
	weapon.attack(direction)
	weapon.weapon_vector = direction

func _die():
	#Potential animations etc for dying
	self.queue_free()
	
# Public beahviour call
func start_attacking():
	attack = true
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		self._die()
