extends Enemy

func _ready() -> void:
	health = 1000

func _process(delta: float) -> void:
	if anim.current_animation == "Hurt":
		await anim.animation_finished
		anim.play("Idle")
