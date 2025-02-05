@tool
class_name EnemySpawner
extends Node2D

@export var enemy_size: Vector2 = Vector2(128, 128)
@export var waves_data: Array[WaveSpawnData]

var _spawn_region_h: Vector2 = Vector2.ZERO
var _spawn_region_v: float = -enemy_size.y

var _spawn_timer: Timer = null
var _wave_timer: Timer = null
var _wave_index: int = 0


func _ready() -> void:
	if Engine.is_editor_hint():
		return

	_spawn_region_h.x = enemy_size.x
	var viewport_size = get_viewport_rect().size
	_spawn_region_h.y = viewport_size.x - _spawn_region_h.x * 2

	_wave_timer = Utils.create_timer(self, _handle_wave_timer_finished, 1.0, true)
	_spawn_timer = Utils.create_timer(self, _handle_spawn_timer_finished, 1.0)

	if !waves_data.is_empty():
		_spawn_enemy()
		_start_spawn()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()


func _handle_spawn_timer_finished() -> void:
	_spawn_enemy()


func _handle_wave_timer_finished() -> void:
	_spawn_timer.stop()
	var next_wave_index: int = _wave_index + 1

	if Utils.is_valid_index(next_wave_index, waves_data):
		_wave_index = next_wave_index

	_start_spawn()


func _start_spawn() -> bool:
	var wave_data: WaveSpawnData = waves_data[_wave_index]
	_wave_timer.start(wave_data.duration)
	_spawn_timer.start(wave_data.spawn_delay)
	return true


func _spawn_enemy() -> void:
	var wave_data: WaveSpawnData = waves_data[_wave_index]
	var spawn_num: int = wave_data.spawn_num

	for i in range(spawn_num):
		var spawn_position: Vector2 = Vector2.ZERO
		spawn_position.x = randf_range(_spawn_region_h.x, _spawn_region_h.y)
		spawn_position.y = _spawn_region_v

		var new_enemy: Enemy = waves_data[_wave_index].enemy_scene.instantiate()
		new_enemy.global_position = spawn_position
		add_child(new_enemy)


func _draw() -> void:
	if !Engine.is_editor_hint():
		return

	var rect: Rect2 = Rect2()
	rect.size = enemy_size
	rect.size.x = (
		ProjectSettings.get_setting("display/window/size/viewport_width") - enemy_size.x * 2
	)
	rect.position.x = enemy_size.x
	rect.position.y = Vector2.UP.y * enemy_size.y
	draw_rect(rect, Color.RED, false, 5.0, false)
