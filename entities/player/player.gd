class_name Player
extends CharacterBody2D

@onready var animation_controller: PlayerAnimaitonController = %Body as PlayerAnimaitonController
@onready var movement_node: MovementNode = %MovementNode


func _unhandled_key_input(_event: InputEvent) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var dir_x: int = sign(direction.x)
	direction = direction.normalized()

	if movement_node != null:
		movement_node.apply_movement(direction)

	if animation_controller != null:
		if direction.x != 0:
			animation_controller.flip_h = dir_x < 0
			animation_controller.play_move_animation()
		else:
			animation_controller.play_stop_animation()
