extends Node2D

@onready var _score_counter: ScoreCounter = %ScoreCounter
@onready var _enemy_spawner: EnemySpawner = %EnemySpawner


func _ready() -> void:
	if _enemy_spawner != null:
		_enemy_spawner.on_enemy_spawned.connect(_handle_enemy_spawned)


func _handle_enemy_spawned(enemy: Enemy) -> void:
	if enemy == null:
		return

	enemy.on_enemy_died.connect(_handle_enemy_died, CONNECT_ONE_SHOT)


func _handle_enemy_died(score: int) -> void:
	if _score_counter == null:
		return

	_score_counter.increase_score(score)
