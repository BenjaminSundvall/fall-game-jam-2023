extends Node

const PORT = 6349
const MAX_CLIENTS = 6
const DEFAULT_ADDRESS = "127.0.0.1"

var peer = ENetMultiplayerPeer.new()

# =============================================== 
#    Server
# ===============================================

# Common signals
signal player_connect(id: int, player_info)
signal player_disconnect(id: int)

# Clients signals
signal client_connection_success
signal client_connection_fail
signal client_server_disonnect

var connected_players = {}

func start_server():
	#print_debug(player_name + " : Im going to be a server!")
	var error = peer.create_server(PORT, MAX_CLIENTS)
	if error:
		print_debug(error)
		return error
	multiplayer.multiplayer_peer = peer
	
	var my_id = multiplayer.get_unique_id()
	
	connected_players[my_id] = player_name
	player_connect.emit(my_id, player_name)


# =============================================== 
#    Client
# ===============================================

var player_name = "Muffin Man"

func start_client(ip_address=DEFAULT_ADDRESS):
	#print_debug(player_name + " : Trying to be a client, it is hard")
	var error = peer.create_client(ip_address, PORT)
	if error:
		print_debug(error)
		return error
	multiplayer.multiplayer_peer = peer


# -- Client - Events ----------------------------
		
func _on_connected_ok():
	#print_debug(player_name + " : Im in, baby!")
	var my_id = multiplayer.get_unique_id()
	connected_players[my_id] = player_name
	player_connect.emit(my_id, player_name)
	client_connection_success.emit()
	
# If try to connect and fail
func _on_connected_fail():
	#print_debug(player_name + " : I couldn't join")
	multiplayer.multiplayer_peer = null
	connected_players = {}
	client_connection_fail.emit()

func _on_server_disconnected():	
	#print_debug(player_name + " : Server left me!")
	multiplayer.multiplayer_peer = null
	connected_players = {}
	client_server_disonnect.emit()


# =============================================== 
#    Events (on each instance)
# ===============================================

# When a player connects to the current session
func _on_player_connected(id):
	_greet_new_player.rpc_id(id, player_name)
	#print_debug(player_name + " : Player connected with id " + str(id))

@rpc("any_peer", "reliable")
func _greet_new_player(greeting_player_name):
	var greeting_player_id = multiplayer.get_remote_sender_id()
	connected_players[greeting_player_id] = greeting_player_name
	player_connect.emit(greeting_player_id, greeting_player_name)
	
	#print_debug(player_name + " : I was just greeted by " + greeting_player_name + ". Thats so nice!")

# When a player disconnects from the current session
func _on_player_disconnected(id):
	connected_players.erase(id)
	player_disconnect.emit(id)
	#print_debug(player_name + " : Player disconnected")


# =============================================== 
#    General
# ===============================================

@rpc("reliable")
func get_player_name():
	return player_name

func set_player_name(new_player_name):
	player_name = new_player_name

func stop_network():
	multiplayer.multiplayer_peer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set all events
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
