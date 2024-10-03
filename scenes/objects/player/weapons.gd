extends Node3D

@export_subgroup("Weapons")
@export var weapons: Array[Weapon] = []

var weapon: Weapon
var old_weapon_index := 0 # Shouldn't need it
var weapon_index := 0

func _ready() -> void:
	weapon = weapons[weapon_index] # Weapon must never be nil

func _process(delta: float) -> void:
	if weapons[old_weapon_index].lowering: return
	
	if Input.is_action_just_pressed("switch_previous"):
		old_weapon_index = weapon_index
		weapon_index = wrap(weapon_index - 1, 0, weapons.size())
		initiate_change_weapon(weapon_index, old_weapon_index)

	if Input.is_action_just_pressed("switch_next"):
		old_weapon_index = weapon_index
		weapon_index = wrap(weapon_index + 1, 0, weapons.size())
		initiate_change_weapon(weapon_index, old_weapon_index)

func initiate_change_weapon(index, old_index) -> void:
	weapons[old_index].deselect_weapon()
	await weapons[old_index].lowered
	weapons[old_index].visible = false
	weapons[old_index].set_process_mode(PROCESS_MODE_DISABLED)
	weapons[index].visible = true
	weapons[index].set_process_mode(PROCESS_MODE_INHERIT)
	weapons[index].select_weapon()
