class_name ScoreCounter
extends Node

signal on_score_increased(new_score: int, amount: int)

var _score: int = 0


func increase_score(amount: int) -> bool:
	if amount <= 0:
		return false

	_score += amount
	on_score_increased.emit(_score, amount)
	return true


func get_score() -> int:
	return _score
