extends Node

var Menu 
var Credits
var Multiplayer : Control

@export var NetworkManager : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Menu/Start").connect("button_up", _on_start_up)
	get_node("Menu/Credits").connect("button_up", _on_credits_up)
	get_node("Menu/Exit").connect("button_up", _on_exit_up)
	get_node("Credits/Back").connect("button_up", _on_back_up)
	
	Menu = get_node("Menu") 
	Credits = get_node("Credits")
	Multiplayer = get_node("Multiplayer")
	
	Menu.visible = true
	Credits.visible = false
	Multiplayer.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# ===============================================
#    Start game
# ===============================================

func _on_start_up():
	$"../..".start_offline_game()
	

func _on_start_online_game_pressed():
	$"../..".start_online_game()
	

# ===============================================
#    Other buttons
# ===============================================
	
func _on_credits_up():
	Menu.visible = false
	Credits.visible = true
	Multiplayer.visible = false


func _on_exit_up():
	get_tree().quit()


func _on_back_up():
	Menu.visible = true
	Credits.visible = false
	Multiplayer.visible = false


func _on_multiplayer_pressed():
	Menu.visible = false
	Credits.visible = false
	Multiplayer.visible = true


