extends StateNode

# Constants
const SPEED = 8.0
const JUMP_VELOCITY = 5
const ACCELERATION = 8
const DECELERATION = 16

# References
var player: CharacterBody3D
var anim: AnimationPlayer
var kickCooldown: Timer
var groundRay: RayCast3D
var stepTimer: Timer

# Variables
var justLanded = false

func _state_machine_ready() -> void:
	player = get_target()
	anim = player.get_node(^"WorldModel/AnimationPlayer")
	kickCooldown = player.get_node(^"KickCooldown")
	groundRay = player.get_node(^"GroundRay")
	stepTimer = player.get_node(^"StepTimer")

func _footstep() -> void:
	if groundRay.is_colliding() and stepTimer.is_stopped():
		var other = groundRay.get_collider()
	# If there's a way to do this with a match, I'd love to hear it.
		if other.is_in_group("dirt"):
			SoundManager.play("player", "stepdirt")
#			print("dirt")
		elif other.is_in_group("snow"):
			SoundManager.play("player", "stepsnow")
#			print("snow")
		elif other.is_in_group("stone"):
			SoundManager.play("player", "stepstone")
#			print("stone")
		elif other.is_in_group("water"):
			SoundManager.play("player", "stepwater")
#			print("water")
		elif other.is_in_group("wood"):
			SoundManager.play("player", "stepwood")
#			print("wood")
		elif other.is_in_group("grass"):
			SoundManager.play("player", "stepgrass")
#			print("grass")
		else:
			SoundManager.play("player", "stepstone")
#			print("none")
		stepTimer.start()
