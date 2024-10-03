extends "common_state.gd"

func _enter_state(_previous_state: String) -> void:
	if Input.is_action_just_pressed("jump"):
		SoundManager.play("player", "jump")
		player.velocity.y = JUMP_VELOCITY
	anim.speed_scale = 1
	anim.play(&"Jump-Transition")
	await anim.animation_finished
	anim.play(&"Jump")

func _physics_process_state(_delta: float) -> String:
	if GameState.player_direction.x:
		player.velocity.x = lerpf(player.velocity.x, GameState.player_direction.x * SPEED, _delta * ACCELERATION/5)
	if GameState.player_direction.z:
		player.velocity.z = lerpf(player.velocity.z, GameState.player_direction.z * SPEED, _delta * ACCELERATION/2.5)
	
	if name == "Jump":
		if Input.is_action_just_pressed("kick") and kickCooldown.is_stopped():
			return "Kick"
		var minimum: float = 0
		if Input.is_action_just_released(&"jump") and player.velocity.y > minimum:
			player.velocity.y = lerpf(player.velocity.y, minimum, _delta*30)
		
		if player.velocity.y <= 0.0:
			return "Fall"
	
	return ""
