extends Node

var network_manager
var actor_space : Node

@export var player : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	network_manager = $".."
	actor_space = $"../../Scene"
	
func _on_start_server_pressed():
	network_manager.set_player_name("Server Sereh")
	network_manager.start_server()
	
func _on_start_client_pressed():	
	network_manager.set_player_name("Client Clive")
	network_manager.start_client()
	
func _on_start_client_2_pressed():	
	network_manager.set_player_name("Client Clara")
	network_manager.start_client()


func _on_net_work_man_anger_player_connect(id):
	if multiplayer.is_server():
		var new_player = player.instantiate()
		new_player.name = str(multiplayer.get_unique_id()) + " : Player - " + str(id)
		new_player.set_id.rpc(id)
		
		actor_space.add_child(new_player)

