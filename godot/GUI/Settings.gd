extends Node

var Player
var toggle

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Container/Continue").connect("button_up", _on_continue_up)
	get_node("Container/Exit").connect("button_up", _on_exit_up)
	get_node("Container/Restart").connect("button_up", _on_restart_up)
	
	Player = get_parent().get_node("Player")
	toggle = false
	self.visible = toggle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_continue_up():
	toggle = false
	Player.paused = toggle
	self.visible = toggle
	pass

func _on_exit_up():
	get_tree().change_scene_to_file("res://GUI/Menu.tscn")	
	pass

func _on_restart_up():
	get_tree().change_scene_to_file("res://Scene/test.tscn")
	pass

func _input(event):
	self.global_position = Player.get_node("Camera").global_position
	if event.is_action_released("ToggleMenu"):
		toggle = !toggle
		Player.paused = toggle
		self.visible = toggle
