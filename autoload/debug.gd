extends Node
func _unhandled_input(event):
	if (event is InputEventKey) and event.pressed:
		match event.keycode:
			KEY_F1: # Hide/show HUD
				if GameState.hud_visible:
					GameState.hud_visible = false
				else:
					GameState.hud_visible = true
			#KEY_F2:
			# F3 is already used by the debug plugin I downloaded
			#KEY_F4:
			KEY_F5: # Reload current scene
				get_tree().reload_current_scene()
			KEY_F6: # Mute/unmute music
				if MusicManager._volume == 0:
					MusicManager.set_volume(-80)
				else:
					MusicManager.set_volume(0)
			#KEY_F7:
			# F8 is used to close the game by default, so it won't be defined here
			#KEY_F9:
			#KEY_F10:
			KEY_F11: # Fullscreen/windowed
				match DisplayServer.window_get_mode():
					DisplayServer.WINDOW_MODE_WINDOWED:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
					DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					_:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			#KEY_F12:
