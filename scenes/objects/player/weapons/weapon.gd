extends Node3D

class_name Weapon

# Signals
signal lowered
var lowering := false
signal raised
var raising := false

# Variables
var fireable := false

# References
@onready var anim = $Model/AnimationPlayer
@onready var player = get_parent().get_parent().get_parent().get_parent()
@onready var raycast = player.get_node("GunRay")
@onready var camera = get_parent().get_parent() # Go two layers up

func _ready() -> void:
	anim.play("Lower")

func select_weapon() -> void:
	fireable = false
	anim.play("Raise")
	raising = true
	await anim.animation_finished
	raising = false
	emit_signal("raised")
	anim.play("Idle")
	fireable = true

func deselect_weapon() -> void:
	fireable = false
	anim.play("Lower")
	lowering = true
	await anim.animation_finished
	emit_signal("lowered")
	lowering = false

## Fires a hitscan attack where [code]raycast[/code] is pointing.
func fire_hitscan(pellets: int, spread_h: float, spread_v: float, damage: int, damageType: String = "None", bulletPuff: PackedScene = preload("res://scenes/effects/impact.tscn")):
	var target_pos = raycast.target_position
	for n in pellets:
		
		raycast.target_position.z = raycast.target_position.z + randf_range(-spread_h, spread_h)
		raycast.target_position.y = raycast.target_position.y + randf_range(-spread_v, spread_v)
		
		raycast.force_raycast_update()
		
		if !raycast.is_colliding(): continue # Don't create impact when raycast didn't hit
		
		var collider = raycast.get_collider()
#		print("collided with " + collider.name)
		
		# Hitting an enemy
		
		if collider.has_method("damage"):
			collider.damage(damage, damageType)
		
		# Creating an impact animation
		
		var impact = bulletPuff
		var impact_instance = impact.instantiate()
		
		get_tree().root.add_child(impact_instance)
		
		impact_instance.position = raycast.get_collision_point() + (raycast.get_collision_normal() / 10)
		raycast.target_position = target_pos
# Reset one more time so you never fuck up where your raycast is pointing
	raycast.target_position = target_pos

func fire_projectile(projectile: PackedScene = preload("res://scenes/objects/player/weapons/projectiles/generic_projectile.tscn"), count: int = 1, spread_h: float = 0, spread_v: float = 0, offset_x: float = 0, offset_y: float = 0, offset_z: float = 0):
	for n in count:
		var projectile_instance = projectile.instantiate()

		projectile_instance.rotation.y = camera.rotation.y + randf_range(-spread_h, spread_h)
		projectile_instance.rotation.z = camera.rotation.z + randf_range(-spread_v, spread_v)
	# i sincerely hope this is relative to the player, but if not it's not that big of a deal
		projectile_instance.position.x = player.position.x + camera.position.x + offset_x
		projectile_instance.position.y = player.position.y + camera.position.y + offset_y
		projectile_instance.position.z = player.position.z + camera.position.z + offset_z
		
		get_tree().root.add_child(projectile_instance)
