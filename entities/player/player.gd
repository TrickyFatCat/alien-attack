class_name Player
extends CharacterBody2D

@onready var movement_node: MovementNode = %MovementNode


func _unhandled_key_input(_event: InputEvent) -> void:
	if movement_node != null:
		var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		movement_node.apply_movement(direction)
