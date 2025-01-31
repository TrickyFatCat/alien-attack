class_name PlayerAnimaitonController
extends AnimatedSprite2D

const ANIM_IDLE: String = "idle"
const ANIM_MOVE: String = "move"
const ANIM_STOP: String = "stop"


func _ready() -> void:
	animation_finished.connect(_handle_animation_finished)


func _handle_animation_finished() -> void:
	if animation == ANIM_STOP:
		play_idle_animation()


func _play_animation(anim_name: String) -> bool:
	if anim_name == null:
		return false

	if animation == anim_name:
		return false

	play(anim_name)
	return true


func play_idle_animation() -> bool:
	return _play_animation(ANIM_IDLE)


func play_move_animation() -> bool:
	return _play_animation(ANIM_MOVE)


func play_stop_animation() -> bool:
	if animation == ANIM_IDLE:
		return false

	return _play_animation(ANIM_STOP)
