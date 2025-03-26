class_name HitPoints
extends Resource

signal on_hitpoints_decreased(amount: int, new_value: int)
signal on_hitpoints_reached_zero

## The current hit points value. Defaults to 1.
@export var hit_points: int = 1


## Decreases the hit points by the specified amount.
##
## Parameter amount: The amount to decrease the hit points by. Must be greater than 0.
## Returns `true` if the hit points were decreased, `false` if the amount was invalid (<= 0).
func decrease(amount: int = 1) -> bool:
	if amount <= 0:
		return false

	hit_points -= amount
	hit_points = max(0, hit_points)
	on_hitpoints_decreased.emit(amount, hit_points)

	if hit_points == 0:
		on_hitpoints_reached_zero.emit()

	return true
