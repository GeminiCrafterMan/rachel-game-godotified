extends "common_state.gd"

func _enter_state(_previous_state: String) -> void:
	SoundManager.play("kahuna", "fire")
	anim.play(&"Fire")
	timer.start(0.25)

func _process_state(_delta: float) -> String:
	if timer.is_stopped():
		match anim.current_animation:
			"Fire":
				print(anim.current_animation)
				SoundManager.play("kahuna", "pump")
				anim.play(&"Pump")
				timer.start(0.5)
				return ""
			"Pump":
				print(anim.current_animation)
				if Input.is_action_pressed("fire"):
					return "Fire"
				return "Idle"
			_:
				print(anim.current_animation)
				return ""
	else:
		return ""
