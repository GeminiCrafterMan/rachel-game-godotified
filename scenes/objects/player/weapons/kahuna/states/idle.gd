extends "common_state.gd"

func _enter_state(_previous_state: String) -> void:
	anim.play(&"Idle")

func _process_state(_delta: float) -> String:
	if Input.is_action_pressed("fire"):
		return "Fire"
	elif Input.is_action_pressed("altfire"):
		return "AltFire"
	else:
		return ""
