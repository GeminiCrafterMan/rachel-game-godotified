extends Node3D

class_name Enemy

# Variables
var health = 100

# References
@onready var anim = $Model/AnimationPlayer
@onready var hitbox = $CollisionShape3D

## Take [code]amount[/code] damage of [code]type[/code].
## Override to define weaknesses or custom hurt/death behaviors.
func damage(amount, type):
	match type: # Damage type reactions
		_:
			pass
	health -= amount
	
	anim.play("Hurt")
	
	if health < 0:
		hitbox.disabled = true
		anim.play("Death")
		#queue_free() # Die
