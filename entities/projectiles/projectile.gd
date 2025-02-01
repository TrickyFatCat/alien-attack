class_name Projectile
extends CharacterBody2D

enum MovementDirection { UP, DOWN }

@export var movement_dir: MovementDirection = MovementDirection.UP


func _ready() -> void:
	var movement_node: MovementNode = %MovementNode
	var direction: Vector2 = Vector2.ZERO

	match movement_dir:
		MovementDirection.UP:
			direction = Vector2.UP
		MovementDirection.DOWN:
			direction = Vector2.DOWN

	if movement_node != null:
		movement_node.set_momevemnt_direction(direction)
