extends Node

var PORT = 67349
var MAX_CLIENTS = 6

# =============================================== 
#    Server
# ===============================================

signal player_connect(id: int, player_info)
signal player_disconnect(id: int)
signal server_disonnect

var connected_players = {}

func start_server():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer

func on_peer_connected(id: int):
	pass
	
func on_peer_disconnected(id: int):
	pass

# =============================================== 
#    Client
# ===============================================

var player_name = "Muffin Man"

func start_client(ip_address):
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_address, PORT)
	multiplayer.multiplayer_peer = peer


func on_connected_to_server():
	pass
	
func connection_failed():
	pass
	
func server_disconnected():
	pass


# =============================================== 
#    General
# ===============================================

func stop_network():
	multiplayer.multiplayer_peer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	
	
# =============================================== 
#    Events
# ===============================================
	
func _on_player_connected():
	pass

func _on_player_disconnected():
	pass
	
func _on_connected_ok():
	pass
	
func _on_connected_fail():
	pass

func _on_server_disconnected():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
