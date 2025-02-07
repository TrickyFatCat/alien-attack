extends Control

@onready var _score_counter: ScoreCounter = %ScoreCounter
@onready var _score_text: Label = %Text_Score


func _ready() -> void:
	if _score_counter != null:
		_score_counter.on_score_increased.connect(_handle_score_increased)
		_handle_score_increased(_score_counter.get_score(), 0)


func _handle_score_increased(new_score: int, _amount: int) -> void:
	if _score_text == null:
		return

	_score_text.text = str(new_score)
