class_name Enemy
extends Area2D

@export var hitpoints: HitPoints = null


func _ready() -> void:
	if hitpoints != null:
		Utils.register_hitpoints(self, hitpoints)
		hitpoints.on_hitpoints_reached_zero.connect(_handle_hitpoints_reached_zero)


func _handle_hitpoints_reached_zero() -> void:
	queue_free()
