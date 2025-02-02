class_name MovementNode
extends Node

@export var movement_data: MovementData = null

var _movement_dir: Vector2 = Vector2.ZERO
var _velocity: Vector2 = Vector2.ZERO

@onready var _body: Node2D = owner as Node2D


func _ready() -> void:
	if movement_data != null:
		_movement_dir = movement_data.calculate_direction()


func _physics_process(delta: float) -> void:
	if _body == null || movement_data == null:
		return

	_velocity = movement_data.max_speed * _movement_dir
	_body.global_position += _velocity * delta


func set_momevemnt_direction(value: Vector2) -> void:
	if _body == null || movement_data == null:
		return

	_movement_dir = value.normalized()
