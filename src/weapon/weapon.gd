class_name Weapon
extends Node2D

@export var projectile_scene: PackedScene = null
@export var damage: int = 1


func shoot() -> bool:
	if projectile_scene == null:
		return false

	var new_projectile: Projectile = projectile_scene.instantiate()
	add_child(new_projectile)
	new_projectile.global_position = global_position
	new_projectile.damage = damage
	return true
