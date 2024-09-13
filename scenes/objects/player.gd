extends CharacterBody3D

# Variables
var JUST_LANDED = false

# Constants
const SPEED = 8.0
const JUMP_VELOCITY = 5
const ACCELERATION = 4
const DECELERATION = 8
const MOUSE_SENSITIVITY = 0.002

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		$Cameras/FirstPersonCamera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		$Cameras/FirstPersonCamera.rotation.x = clampf($Cameras/FirstPersonCamera.rotation.x, -deg_to_rad(90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	
func handle_movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		JUST_LANDED = true

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		SoundManager.play("player", "jump")
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		# Play landing sound
		if JUST_LANDED == true:
			if SoundManager.has_loaded: # Wait for the sound manager to load first!
				SoundManager.play("player", "land")
			JUST_LANDED = false
		else:
			# Accelerate
			if direction:
				velocity.x = lerpf(velocity.x, direction.x * SPEED, delta * ACCELERATION)
				velocity.z = lerpf(velocity.z, direction.z * SPEED, delta * ACCELERATION)
			# Decelerate
			else:
				velocity.x = lerpf(velocity.x, direction.x * SPEED, delta * DECELERATION)
				velocity.z = lerpf(velocity.z, direction.z * SPEED, delta * DECELERATION)
	else:
		if direction.x:
			velocity.x = lerpf(velocity.x, direction.x * SPEED, delta * ACCELERATION/5)
		if direction.z:
			velocity.z = lerpf(velocity.z, direction.z * SPEED, delta * ACCELERATION/2.5)

	move_and_slide()
