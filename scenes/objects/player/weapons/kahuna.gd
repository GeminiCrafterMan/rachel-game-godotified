extends Weapon

# Variables
var spread : int

# References
@onready var kahunaTimer = $kahunaTimer

func _process(_delta):
	spread = clamp(spread, 0, 24) # Clamp it
	if fireable == true:
		if Input.is_action_pressed("fire"): # Primary fire
			fireable = false
			SoundManager.play("kahuna", "fire")
			anim.play("Fire")
			fire_hitscan(12, 5 + (spread*0.4), 5 + (spread*0.4), 10, "Shotgun")
			await anim.animation_finished
			SoundManager.play("kahuna", "pump")
			anim.play("Pump")
			await anim.animation_finished
			fireable = true
		elif Input.is_action_pressed("altfire"): # Secondary fire
			fireable = false
			SoundManager.play("kahuna", "fire")
			anim.play("Fire")
			fire_hitscan(12, 4 + (spread*0.8), 4 + (spread*0.8), 11, "Shotgun")
			spread += 2
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
		else: # Idling
			if spread > 0:
				if kahunaTimer.is_stopped():
					spread -= 1
					kahunaTimer.start()
