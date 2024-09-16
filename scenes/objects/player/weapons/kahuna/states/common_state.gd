extends StateNode

# Constants

# References
var kahuna: Node3D
var anim: AnimationPlayer

# Variables

func _state_machine_ready() -> void:
	kahuna = get_target()
	anim = kahuna.get_node(^"Model/AnimationPlayer")
