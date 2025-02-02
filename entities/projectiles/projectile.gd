class_name Projectile
extends Area2D

var damage: int = 1:
	set(value):
		if value < 0:
			return

		damage = value
	get:
		return damage


func _ready() -> void:
	top_level = true
	area_entered.connect(_handle_area_entered)


func _handle_area_entered(area: Area2D) -> void:
	if Utils.apply_damage(area, damage):
		queue_free()
