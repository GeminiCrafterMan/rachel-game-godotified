extends Node3D

func _input(event):
	if Input.is_action_just_pressed("fire"):
		$AnimationPlayer.play("Fire")
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("Pump")
