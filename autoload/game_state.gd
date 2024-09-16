extends Node

var hud_visible = true # Set to false to hide the HUD
var player # Absolute path to player node
var player_direction = Vector3.ZERO # Updated from player so the game doesn't crash
var player_force_slide = false # Set to true to force sliding

func _process(_delta: float) -> void:
	pass
