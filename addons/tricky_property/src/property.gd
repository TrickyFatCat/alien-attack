class_name TrickyProperty
extends Resource

signal min_value_increased(new_value: float, amount: float)
signal min_value_decreased(new_value: float, amount: float)
signal value_increased(new_value: float, normalized_value: float, amount: float)
signal value_decreased(new_value: float, normalized_value: float, amount: float)
signal max_value_increased(new_value: float, amount: float)
signal max_value_decreased(new_value: float, amount: float)
signal value_reached_min
signal value_reached_max

@export var default_min_value: float = 0.0:
	set(new_value):
		default_min_value = new_value
		min_value = new_value

	get:
		return default_min_value

@export var default_value: float = 100.0:
	set(new_value):
		default_value = new_value
		value = new_value

	get:
		return default_value

@export var default_max_value: float = 100.0:
	set(new_value):
		default_max_value = new_value
		max_value = new_value

	get:
		return default_max_value

var min_value: float = default_min_value
var value: float = default_value
var max_value: float = default_max_value


## Increases min_value by a given amount.
## Return true if min_value successfully increased.
func increase_min_value(amount: float) -> bool:
	if amount <= 0:
		return false

	min_value += amount
	min_value_increased.emit(min_value, amount)
	return true


func decrease_min_value(amount: float) -> bool:
	if amount <= 0:
		return false

	min_value -= amount
	min_value_decreased.emit(min_value, amount)
	return true


func increase_value(amount: float) -> bool:
	if amount <= 0:
		return false

	value += amount
	value_increased.emit(value, get_normalized_value(), amount)

	if value >= max_value:
		value_reached_max.emit()

	return true


func decrease_value(amount: float) -> bool:
	if amount <= 0:
		return false

	value -= amount
	value_decreased.emit(value, get_normalized_value(), amount)

	if value <= min_value:
		value_reached_min.emit()

	return true


func increase_max_value(amount: float) -> bool:
	if amount <= 0:
		return false

	max_value += amount
	max_value_increased.emit(max_value, amount)
	return true


func decrease_max_value(amount: float) -> bool:
	if amount <= 0:
		return false

	max_value -= amount
	max_value_decreased.emit(max_value, amount)
	return true


func clamp_to_min_value() -> void:
	value = max(value, min_value)


func clamp_to_max_value() -> void:
	value = min(value, max_value)


func get_normalized_value() -> float:
	return value / max_value if max_value > 0.0 else 0.0


func add_to_meta(node: Node, name: String) -> void:
	if node == null || name.is_empty():
		return

	if node.has_meta(name):
		return

	node.set_meta(name, self)


func set_values(new_min_value: float, new_value: float, new_max_value: float) -> void:
	min_value = new_min_value
	value = new_value
	max_value = new_max_value
