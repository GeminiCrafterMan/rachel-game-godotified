extends "common_state.gd"

func _enter_state(_previous_state: String) -> void:
	anim.play(&"Idle")

func _physics_process_state(_delta: float) -> String:
	if Input.is_action_just_pressed("fire"):
		return "Fire"
	elif Input.is_action_just_pressed("altfire"):
		return "AltFire"
	else:
		return ""
