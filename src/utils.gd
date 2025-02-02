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
