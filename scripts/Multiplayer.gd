extends Node2D

const PORT = 123
const SERVER_ADDRESS = "localhost"
var peer = ENetMultiplayerPeer.new()

@export var PlayerField_scene : PackedScene
@export var OpponentsField_scene : PackedScene

func _on_host_button_pressed():
	enable_buttons(false)
	peer.create_server(PORT)

	#multiplayer is built in and can be accessed anywhere in godot
	#we assign the object responsible for networking
	multiplayer.multiplayer_peer = peer

	multiplayer.peer_connected.connect(_on_peer_connected)

	var player_scene = PlayerField_scene.instantiate()
	add_child(player_scene)

func _on_join_button_pressed():
	enable_buttons(false)
	
	peer.create_client(SERVER_ADDRESS, PORT)
	#multiplayer is built in and can be accessed anywhere in godot
	#we assign the object responsible for networking
	multiplayer.multiplayer_peer = peer
	
	var player_scene = PlayerField_scene.instantiate()
	add_child(player_scene)

	

func enable_buttons(are_enabled):
	$HostButton.disabled = are_enabled
	$JoinButton.disabled = are_enabled
	$HostButton.visible = are_enabled
	$JoinButton.visible = are_enabled

func _on_peer_connected(peer_id):
	print("User connected")
	draw_opponent()
	rpc("draw_opponent")


@rpc("any_peer")
func draw_opponent():
	var opponent_scene = OpponentsField_scene.instantiate()
	add_child(opponent_scene)
