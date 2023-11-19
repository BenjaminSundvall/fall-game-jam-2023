extends Control

@onready var MenuController = $".."

@onready var IPInputField = $"HBoxContainer/IP input" 

var NetworkManager

func _ready():
	$"Start Game".visible = false
	
	NetworkManager = MenuController.NetworkManager
	$"Name field".text = NetworkManager.player_name
	
	NetworkManager.player_connect.connect(_player_connect)
	NetworkManager.player_disconnect.connect(_player_disconnect)
	NetworkManager.client_connection_success.connect(_client_connection_success)
	NetworkManager.client_connection_fail.connect(_client_connection_fail)
	NetworkManager.client_server_disonnect.connect(_client_server_disonnect)


# ===============================================
#    Events on network
# ===============================================

func _player_connect(id: int, player_info):
	if id != multiplayer.get_unique_id():
		_print_in_chat("Player joined: " + player_info + " (" + str(id) + ")")

func _player_disconnect(id: int):
	_print_in_chat("Player left: " + str(id))

func _client_connection_success():
	hide_networking()
	var players_in = NetworkManager.connected_players
	#print_debug(multiplayer.get_unique_id())
	$ID.text = "ID: " + str(multiplayer.get_unique_id())
	_print_in_chat("Joined server")
		
func _client_connection_fail():
	_print_in_chat("Couldn't connect")

func _client_server_disonnect():
	$HBoxContainer/Back.pressed.emit()

func _print_in_chat(text):
	$Log.text += text + "\n"


# ===============================================
#    Events on network
# ===============================================

func client_join():
	NetworkManager.player_name = $"Name field".text
	NetworkManager.start_client(IPInputField.text)

func server_join():
	NetworkManager.player_name = $"Name field".text
	NetworkManager.start_server()
	_print_in_chat("Server started")
	hide_networking()
	$"Start Game".visible = true
	$ID.text = "ID: " + str(multiplayer.get_unique_id())
	
func hide_networking():
	show_networking(false)

func show_networking(visible=true):
	$"HBoxContainer/Server Start".visible = visible
	$"HBoxContainer/Client Join".visible = visible
	$"HBoxContainer/IP input".visible = visible
	$"Name field".editable = visible


func _on_back_pressed():
	show_networking()
	$"Start Game".visible = false
	
