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

# Variables
var justLanded = false

func _state_machine_ready() -> void:
	player = get_target()
	anim = player.get_node(^"WorldModel/AnimationPlayer")
	kickCooldown = player.get_node(^"KickCooldown")
