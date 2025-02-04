class_name Utils
extends Node

const HITPOINTS_NAME: String = "HitPoints"


static func has_hitpoints(node: Node) -> bool:
	if node == null:
		return false

	return node.has_meta(HITPOINTS_NAME)


static func register_hitpoints(node: Node, hitpoints: HitPoints) -> void:
	if node == null:
		return

	node.set_meta(HITPOINTS_NAME, hitpoints)


static func get_hitpoints(node: Node) -> HitPoints:
	if node == null || !has_hitpoints(node):
		return null

	return node.get_meta(HITPOINTS_NAME, HitPoints)


static func apply_damage(target: Node, damage: int) -> bool:
	if target == null || !has_hitpoints(target):
		return false

	var hitpoints: HitPoints = get_hitpoints(target)
	return hitpoints.decrease(damage)


static func is_valid_index(index: int, array: Array) -> bool:
	if array == null:
		return false

	return index >= 0 && index < array.size()


static func create_timer(
	node: Node,
	callable: Callable,
	duration: float = 1.0,
	one_shot: bool = false,
	auto_start: bool = false,
) -> Timer:
	if callable == null || node == null:
		return null

	var new_timer: Timer = Timer.new()
	new_timer.wait_time = duration
	new_timer.one_shot = one_shot
	new_timer.autostart = auto_start
	new_timer.timeout.connect(callable)
	node.add_child(new_timer)
	return new_timer
