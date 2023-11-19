extends Weapon
var charge_duration = .7
var start_time = 0
var distance = 500
var charged_distance = 0
var display_charge = false
var dir
# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_damage = 50
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !display_charge:
		return
	start_time += delta	
	charged_distance = distance*(start_time/charge_duration)
	
	if charged_distance > distance:
		_attack(dir)
	
	pass
	
func attack_pressed(direction):
	dir = direction
	display_charge = true
	start_time = 0
	charged_distance = 0

func attack_released(direction):
	if display_charge:
		_attack(direction)
	
func _attack(direction):
	display_charge = false
	var enemy = _get_enemy()
	var bullet = Bullet.instantiate()
	get_node("/root").add_child(bullet)
	bullet.enemy = enemy
	bullet.distance = charged_distance
	bullet.global_position = self.global_position
	bullet.direction = direction.normalized()
	bullet.damage = bullet_damage

