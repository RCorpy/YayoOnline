extends Node2D

const PORT = 123
var peer = ENetMultiplayerPeer.new()

@export var PlayerField_scene : PackedScene
@export var OpponentsField_scene : PackedScene

func _on_host_button_pressed():
	enable_buttons(true)
	peer.create_server(PORT)

	#multiplayer is built in and can be accessed anywhere in godot
	#we assign the object responsible for networking
	multiplayer.multiplayer_peer = peer

func _on_join_button_pressed():
	pass # Replace with function body.

func enable_buttons(are_enabled):
	$HostButton.disabled = !are_enabled
	$JoinButton.disabled = !are_enabled
	$HostButton.visible = !are_enabled
	$JoinButton.visible = !are_enabled
