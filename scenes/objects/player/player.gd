extends CharacterBody3D

# References
@onready var state_machine: StateMachine = $StateMachine

# Variables

# Constants
const MOUSE_SENSITIVITY = 0.002

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameState.player = self.get_path()
	$HUD/StateTracker.text = "State: " + state_machine.initial_state.name

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		$Cameras/FirstPersonCamera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		$Cameras/FirstPersonCamera.rotation.x = clampf($Cameras/FirstPersonCamera.rotation.x, -deg_to_rad(90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	GameState.player_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#	print(player_direction)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func _on_state_machine_state_changed(_previous_state: String, new_state: String) -> void:
	$HUD/StateTracker.text = "State: " + new_state
	pass
