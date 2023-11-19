extends Area2D
class_name Bullet
var damage
var speed
var direction
var enemy
var max_lifetime
var lifetime

@onready var sync_data = $BulletData

# Called when the node enters the scene tree for the first time.
func _ready():
	set_multiplayer_authority(1)
	connect("body_entered", _on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if multiplayer.get_unique_id() == get_multiplayer_authority():
		_update_physics(delta)
		
		if sync_data:
			print_debug("HIT")
			sync_data.sync_position = position
			sync_data.sync_direction = direction
	else:
		position = sync_data.sync_position
		direction = sync_data.sync_direction
	
func _update_physics(delta):
	pass

func _movement(dir):
	pass

func _on_body_entered(body):
	pass
		
	
