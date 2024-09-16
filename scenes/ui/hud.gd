extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_hud()
	_hide_hud(delta)

func _update_hud() -> void:
	$HealthBar.value = get_parent().health
	$KickCooldown.value = get_parent().get_node("KickCooldown").time_left

func _hide_hud(delta: float) -> void:
	if GameState.hud_visible == true:
		$HealthBar.global_position.x = lerpf($HealthBar.global_position.x, 24, delta*6)
		$KickCooldown.global_position.x = lerpf($KickCooldown.global_position.x, 112, delta*6)
	else:
		$HealthBar.global_position.x = lerpf($HealthBar.global_position.x, -280, delta*6)
		$KickCooldown.global_position.x = lerpf($KickCooldown.global_position.x, -192, delta*6)
