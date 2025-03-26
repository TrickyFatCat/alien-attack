@tool
class_name DamageShape
extends Node2D

@export var shape: Shape2D = null:
	set(value):
		if shape == value:
			return

		if shape != null && shape.changed.is_connected(queue_redraw):
			shape.changed.disconnect(queue_redraw)

		shape = value
		if shape != null && !shape.changed.is_connected(queue_redraw):
			shape.changed.connect(queue_redraw)

		queue_redraw()

@export var color: Color = Color(0.545098, 0, 0, 0.5):
	set(value):
		color = value
		queue_redraw()


func _draw() -> void:
	if !Engine.is_editor_hint():
		return

	if shape != null:
		shape.draw(get_canvas_item(), color)
