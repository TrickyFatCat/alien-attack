class_name Projectile
extends Area2D

enum MovementDirection { UP, DOWN }

@export var movement_dir: MovementDirection = MovementDirection.UP

@onready var movement_node: MovementNode = %MovementNode
@onready var visibility_notifier: VisibleOnScreenNotifier2D = %VisibilityNotifier


func _ready() -> void:
	top_level = true
	var direction: Vector2 = Vector2.ZERO

	match movement_dir:
		MovementDirection.UP:
			direction = Vector2.UP
		MovementDirection.DOWN:
			direction = Vector2.DOWN

	if movement_node != null:
		movement_node.set_momevemnt_direction(direction)

	if visibility_notifier != null:
		visibility_notifier.screen_exited.connect(_handle_screen_exited)


func _handle_screen_exited() -> void:
	queue_free.call_deferred()
