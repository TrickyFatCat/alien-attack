extends VisibleOnScreenNotifier2D


func _ready() -> void:
	screen_exited.connect(_handle_screen_exited)


func _handle_screen_exited() -> void:
	owner.queue_free.call_deferred()
