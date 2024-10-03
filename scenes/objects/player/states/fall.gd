extends "jump.gd"

func _enter_state(_previous_state: String) -> void:
	anim.speed_scale = 1
	anim.play(&"Fall-Transition")
	await anim.animation_finished
	anim.play(&"Fall")

func _physics_process_state(delta: float) -> String:
	super(delta)
	if Input.is_action_just_pressed("kick") and kickCooldown.is_stopped():
		return "Kick"
	
	if player.is_on_floor():
		if GameState.player_direction:
			return "Walk"
		else:
			return "Idle"
	
	return ""
