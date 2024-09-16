extends "common_state.gd"

var slide_direction

func _enter_state(_previous_state: String) -> void:
#	anim.play(&"Slide")
	player.get_node("MainHitbox").disabled = true
	player.get_node("SlideHitbox").disabled = false
	if GameState.player_direction:
		slide_direction = GameState.player_direction
	else:
		slide_direction = -player.get_transform().basis.z

func _physics_process_state(_delta: float) -> String:
	# Handle jump.
	if player.is_on_floor():
		if Input.is_action_just_pressed(&"jump"):
			player.get_node("Cameras").position.y = 0
			player.get_node("MainHitbox").disabled = false
			player.get_node("SlideHitbox").disabled = true
			return "Jump"
		# Accelerate
		if Input.is_action_pressed(&"slide") or GameState.player_force_slide == true:
			player.get_node("Cameras").position.y = -1
			player.velocity = (slide_direction * 12)
		# Fix these two to allow you to slide left or right.
#			player.velocity.x = lerpf(player.velocity.x, GameState.player_direction.x * 4, _delta * 2)
#			player.velocity.z = lerpf(player.velocity.z, GameState.player_direction.z * 4, _delta * 2)
			return ""
		# Decelerate
		else:
			player.get_node("Cameras").position.y = 0
			player.get_node("MainHitbox").disabled = false
			player.get_node("SlideHitbox").disabled = true
			if GameState.player_direction:
				return "Walk"
			else:
				return "Idle"
	else:
		justLanded = false
		player.get_node("Cameras").position.y = 0
		player.get_node("MainHitbox").disabled = false
		player.get_node("SlideHitbox").disabled = true
		return "Jump" # Goes to Fall itself.
