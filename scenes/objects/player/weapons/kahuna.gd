extends Node3D

var fireable = true

@onready var anim = $Model/AnimationPlayer

func _process(_delta):
	if fireable == true:
		if Input.is_action_pressed("fire"):
			fireable = false
			SoundManager.play("kahuna", "fire")
			anim.play("Fire")
			await anim.animation_finished
			SoundManager.play("kahuna", "pump")
			anim.play("Pump")
			await anim.animation_finished
			fireable = true
		elif Input.is_action_pressed("altfire"):
			fireable = false
			SoundManager.play("kahuna", "fire")
			anim.play("Fire")
			await anim.animation_finished
			anim.play("Spin")
			anim.speed_scale = 1.5
			await anim.animation_finished
			anim.speed_scale = 1
			if Input.is_action_pressed("altfire"):
				fireable = true
			else:
				SoundManager.play("kahuna", "pump")
				anim.play("Pump")
				await anim.animation_finished
				fireable = true
				
				
		
