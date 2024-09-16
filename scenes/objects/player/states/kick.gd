extends "jump.gd"

func _enter_state(_previous_state: String) -> void:
	kickCooldown.start()
	player.velocity = (player.get_transform().basis.z * -16)
	player.velocity.y = clampf((player.get_node("Cameras/FirstPersonCamera").rotation.x), -deg_to_rad(90), 0) * 16
#	anim.play(&"Kick") # Needs a transitionary state, but honestly you can just use Await for that with a custom animation here

func _physics_process_state(_delta: float) -> String:
	if Input.is_action_just_pressed("kick") and kickCooldown.is_stopped():
		return "Kick"
	if player.is_on_floor():
		if GameState.player_direction:
			return "Walk"
		else:
			return "Idle"
	
	return ""
