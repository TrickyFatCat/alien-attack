extends Control

var _health_icons: Array[Node] = []

@onready var _score_counter: ScoreCounter = %ScoreCounter
@onready var _text_score: Label = %Text_Score
@onready var _text_final_score: Label = %Text_FinalScore
@onready var _screen_game_over: Control = %Screen_GameOver


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

	var button_restart: Button = %Button_Restart

	if button_restart != null:
		button_restart.pressed.connect(_handle_restart_pressed, CONNECT_ONE_SHOT)


func _handle_score_increased(new_score: int, _amount: int) -> void:
	var score_string := str(new_score)

	if _text_score != null:
		_text_score.text = score_string

	if _text_final_score != null:
		_text_final_score.text = score_string


func _handle_player_hitpoints_decreased(_amount: int, new_value: int) -> void:
	if _health_icons.is_empty():
		return

	_health_icons[new_value].visible = false

	if new_value == 0:
		_screen_game_over.visible = true


func _handle_restart_pressed() -> void:
	get_tree().reload_current_scene()
