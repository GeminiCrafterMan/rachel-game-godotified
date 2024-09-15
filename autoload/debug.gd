extends Node
func _unhandled_input(event):
	if (event is InputEventKey) and event.pressed:
		match event.keycode:
			KEY_F1:
				if GameState.hud_visible:
					GameState.hud_visible = false
				else:
					GameState.hud_visible = true
			KEY_F5:
				get_tree().reload_current_scene()
			KEY_F11:
				match DisplayServer.window_get_mode():
					DisplayServer.WINDOW_MODE_WINDOWED:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
					DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					_:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
						
