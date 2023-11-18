extends Node

@export var StartingScene:PackedScene

var Menu 
var Credits

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Menu/Start").connect("button_up", _on_start_up)
	get_node("Menu/Credits").connect("button_up", _on_credits_up)
	get_node("Menu/Exit").connect("button_up", _on_exit_up)
	get_node("Credits/Back").connect("button_up", _on_back_up)
	
	Menu = get_node("Menu") 
	Credits = get_node("Credits")
	
	Menu.visible = true
	Credits.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_up():
	get_tree().change_scene_to_packed(StartingScene)
	pass
	
func _on_credits_up():
	Menu.visible = false
	Credits.visible = true
	pass
	
func _on_exit_up():
	get_tree().quit()
	pass

func _on_back_up():
	Menu.visible = true
	Credits.visible = false
	pass
