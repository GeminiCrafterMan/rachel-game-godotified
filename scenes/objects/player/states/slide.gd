extends "common_state.gd"

func _enter_state(_previous_state: String) -> void:
#	anim.play(&"Slide")
	pass

func _physics_process_state(_delta: float) -> String:
	# Handle jump.
	if player.is_on_floor():
		if Input.is_action_just_pressed(&"jump"):
			return "Jump"
		# Accelerate
		if Input.is_action_pressed(&"slide"):
			player.velocity.x = lerpf(player.velocity.x, GameState.player_direction.x * SPEED, _delta * ACCELERATION)
			player.velocity.z = lerpf(player.velocity.z, GameState.player_direction.z * SPEED, _delta * ACCELERATION)
			return ""
		# Decelerate
		else:
			if GameState.player_direction:
				return "Walk"
			else:
				return "Idle"
	else:
		justLanded = false
		return "Jump" # Goes to Fall itself.
