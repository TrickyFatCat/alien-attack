class_name MovementNode
extends Node

@export var movement_data: MovementData = null

var _character_body: CharacterBody2D = null
var _movement_dir: Vector2 = Vector2.ZERO


func _ready() -> void:
	_character_body = owner as CharacterBody2D


func _physics_process(_delta: float) -> void:
	if _character_body == null || movement_data == null:
		return

	_character_body.velocity = movement_data.max_speed * _movement_dir
	_character_body.move_and_slide()


func set_momevemnt_direction(value: Vector2) -> void:
	if _character_body == null || movement_data == null:
		return

	_movement_dir = value
