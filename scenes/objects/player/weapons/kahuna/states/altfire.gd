extends "common_state.gd"

func _enter_state(_previous_state: String) -> void:
	SoundManager.play("kahuna", "fire")
	anim.play(&"Fire")
	timer.start(0.25)

func _process_state(_delta: float) -> String:
	if timer.is_stopped():
		match anim.current_animation:
			"Fire":
				timer.start(0.21)
				anim.play(&"Spin")
				return ""
			"Spin":
				if Input.is_action_pressed("altfire"):
					return "AltFire"
				else:
					SoundManager.play("kahuna", "pump")
					anim.play(&"Pump")
					timer.start(0.5)
					return ""
			"Pump":
				print("pump")
				return "Idle"
			_:
				return ""
	else:
		return ""
