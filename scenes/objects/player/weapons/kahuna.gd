extends Node3D

var fireable = true

func _process(_delta):
	if fireable == true:
		if Input.is_action_pressed("fire"):
			fireable = false
			SoundManager.play("kahuna", "fire")
			$Model/AnimationPlayer.play("Fire")
			await $Model/AnimationPlayer.animation_finished
			SoundManager.play("kahuna", "pump")
			$Model/AnimationPlayer.play("Pump")
			await $Model/AnimationPlayer.animation_finished
			fireable = true
		elif Input.is_action_pressed("altfire"):
			fireable = false
			SoundManager.play("kahuna", "fire")
			$Model/AnimationPlayer.play("Fire")
			await $Model/AnimationPlayer.animation_finished
			$Model/AnimationPlayer.play("Spin")
			await $Model/AnimationPlayer.animation_finished
			if Input.is_action_pressed("altfire"):
				fireable = true
			else:
				SoundManager.play("kahuna", "pump")
				$Model/AnimationPlayer.play("Pump")
				await $Model/AnimationPlayer.animation_finished
				fireable = true
				
				
		
