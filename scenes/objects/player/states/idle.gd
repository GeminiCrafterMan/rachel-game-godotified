extends "common_state.gd"

func _enter_state(_previous_state: String) -> void:
	if SoundManager.has_loaded: # Wait for the sound manager to load first!
		_footstep()
	anim.play(&"Idle")
	anim.speed_scale = 1

func _physics_process_state(_delta: float) -> String:
	# Handle jump.
	if player.is_on_floor():
		# Play landing sound
		if justLanded == true:
			justLanded = false
			return ""
		else:
			if Input.is_action_just_pressed(&"jump"):
				return "Jump"
			# Accelerate
			if GameState.player_direction:
				return "Walk"
			# Decelerate
			else:
				player.velocity.x = lerpf(player.velocity.x, GameState.player_direction.x * SPEED, _delta * DECELERATION)
				player.velocity.z = lerpf(player.velocity.z, GameState.player_direction.z * SPEED, _delta * DECELERATION)
				return ""
	else:
		justLanded = false
		return "Jump" # Goes to Fall itself.
