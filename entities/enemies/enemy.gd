class_name Enemy
extends Area2D

const EXPLOSION_ANIM: String = "explosion"

@export var hitpoints: HitPoints = null

@onready var movement_node: MovementNode = %MovementNode
@onready var sprite: AnimatedSprite2D = %Sprite


func _ready() -> void:
	if hitpoints != null:
		Utils.register_hitpoints(self, hitpoints)
		hitpoints.on_hitpoints_reached_zero.connect(_handle_hitpoints_reached_zero)


func _handle_hitpoints_reached_zero() -> void:
	movement_node.process_mode = Node.PROCESS_MODE_DISABLED
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)

	if sprite == null:
		queue_free.call_deferred()
		return

	sprite.animation_finished.connect(_handle_animation_finished)
	sprite.play(EXPLOSION_ANIM)


func _handle_animation_finished() -> void:
	if sprite.animation != EXPLOSION_ANIM:
		return

	queue_free.call_deferred()
