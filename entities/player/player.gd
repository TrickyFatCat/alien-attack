class_name Player
extends Area2D

const POS_OFFSET: Vector2 = Vector2(64, 64)

@export var hitpoints: HitPoints = null

var _clamp_pos_h: Vector2 = Vector2.ZERO
var _clamp_pos_v: Vector2 = Vector2.ZERO

@onready var animation_controller: PlayerAnimaitonController = %Body as PlayerAnimaitonController
@onready var movement_node: MovementNode = %MovementNode
@onready var weapon: Weapon = %Weapon
@onready var audio_shot: AudioStreamPlayer2D = %Audio_Shot


func _ready() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size
	_clamp_pos_h.x = POS_OFFSET.x
	_clamp_pos_h.y = viewport_size.x - POS_OFFSET.x
	_clamp_pos_v.x = POS_OFFSET.y
	_clamp_pos_v.y = viewport_size.y - POS_OFFSET.y

	if hitpoints != null:
		Utils.register_hitpoints(self, hitpoints)
		hitpoints.on_hitpoints_reached_zero.connect(_handle_zero_hitpoints)


func _process(_delta: float) -> void:
	_clamp_position()


func _unhandled_key_input(_event: InputEvent) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var dir_x: int = sign(direction.x)
	direction = direction.normalized()

	if movement_node != null:
		movement_node.set_momevemnt_direction(direction)

	if animation_controller != null:
		if direction.x != 0:
			animation_controller.flip_h = dir_x < 0
			animation_controller.play_move_animation()
		else:
			animation_controller.play_stop_animation()

	if Input.is_action_just_pressed("shoot") && weapon != null:
		if !weapon.shoot():
			return

		if audio_shot == null:
			return

		audio_shot.play()


func _clamp_position() -> void:
	position.x = clamp(position.x, _clamp_pos_h.x, _clamp_pos_h.y)
	position.y = clamp(position.y, _clamp_pos_v.x, _clamp_pos_v.y)


func _handle_zero_hitpoints() -> void:
	process_mode = PROCESS_MODE_DISABLED
	animation_controller.play_idle_animation()

	var collision := %Collision

	if collision != null:
		collision.disabled = true
