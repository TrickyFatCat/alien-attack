extends Control

var _health_icons: Array[Node] = []

@onready var _score_counter: ScoreCounter = %ScoreCounter
@onready var _score_text: Label = %Text_Score


func _ready() -> void:
	if _score_counter != null:
		_score_counter.on_score_increased.connect(_handle_score_increased)
		_handle_score_increased(_score_counter.get_score(), 0)

	var health_data := %HealthData

	if health_data != null:
		_health_icons = health_data.get_children()

	var player := %Player

	if player != null && player.hitpoints != null:
		player.hitpoints.on_hitpoints_decreased.connect(_handle_player_hitpoints_decreased)


func _handle_score_increased(new_score: int, _amount: int) -> void:
	if _score_text == null:
		return

	_score_text.text = str(new_score)


func _handle_player_hitpoints_decreased(_amount: int, new_value: int) -> void:
	if _health_icons.is_empty():
		return

	_health_icons[new_value].visible = false
