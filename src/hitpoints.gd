class_name HitPoints
extends Resource

signal on_hitpoints_decreased(amount: int, new_value: int)
signal on_hitpoints_reached_zero

@export var hit_points: int = 1


func decrease(amount: int = 1) -> bool:
	if amount <= 0:
		return false

	hit_points -= amount
	hit_points = max(0, hit_points)
	on_hitpoints_decreased.emit(amount, hit_points)

	if hit_points == 0:
		on_hitpoints_reached_zero.emit()

	return true
