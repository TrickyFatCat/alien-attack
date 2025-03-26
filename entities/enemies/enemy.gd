class_name Enemy
extends Area2D

signal on_enemy_died(score: int)

const EXPLOSION_ANIM: String = "explosion"

@export var score: int = 10
@export var hitpoints: HitPoints = null

@onready var movement_node: MovementNode = %MovementNode
@onready var sprite: AnimatedSprite2D = %Sprite
@onready var collision: CollisionShape2D = %Collision


func _ready() -> void:
	area_entered.connect(_handle_area_entered)

	if hitpoints != null:
		Utils.register_hitpoints(self, hitpoints)
		hitpoints.on_hitpoints_reached_zero.connect(_handle_hitpoints_reached_zero)


func _handle_hitpoints_reached_zero() -> void:
	on_enemy_died.emit(score)
	_explode()


func _handle_animation_finished() -> void:
	if sprite.animation != EXPLOSION_ANIM:
		return

	queue_free.call_deferred()


func _handle_area_entered(area: Area2D) -> void:
	if Utils.apply_damage(area, 1):
		_explode()


func _explode() -> void:
	if sprite.animation == EXPLOSION_ANIM:
		return

	movement_node.process_mode = Node.PROCESS_MODE_DISABLED
	collision.set_deferred("disabled", true)

	if sprite == null:
		queue_free.call_deferred()
		return

	z_index += 2
	sprite.animation_finished.connect(_handle_animation_finished)
	sprite.play(EXPLOSION_ANIM)

	var audio_explosion: AudioStreamPlayer2D = %Audio_Explosion

	if audio_explosion != null:
		audio_explosion.play()
