extends Node3D

func _ready() -> void:
	await MusicManager.loaded # Wait for the sound manager to load first!
	MusicManager.play("testroom", "tek")
