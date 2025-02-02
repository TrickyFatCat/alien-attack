class_name MovementData
extends Resource

enum MovementDirection { UP, DOWN, CUSTOM }

@export var max_speed: float = 100
@export var direction: MovementDirection = MovementDirection.CUSTOM


func calculate_direction() -> Vector2:
	match direction:
		MovementDirection.UP:
			return Vector2.UP
		MovementDirection.DOWN:
			return Vector2.DOWN
	return Vector2.ZERO
