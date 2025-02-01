class_name Weapon
extends Node2D

@export var projectile_scene: PackedScene = null


func shoot() -> bool:
	if projectile_scene == null:
		return false

	var new_projectile: Projectile = projectile_scene.instantiate()
	add_child(new_projectile)
	new_projectile.global_position = global_position
	return true
