class_name Counter
extends Resource

signal value_increased(new_value: int, amount: int)
signal value_decreased(new_value: int, amount: int)

@export var initial_value: int = 0

var value: int = initial_value


func increase_counter(amount: int) -> bool:
	if amount <= 0:
		return false

	value += amount
	value_increased.emit(value, amount)
	return true


func decrease_counter(amount: int) -> bool:
	if amount <= 0:
		return false

	value -= amount
	value_decreased.emit(value, amount)
	return true
