extends Control

signal _show_results

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on__show_results() -> void:
	show()
	var t1 = create_tween()

	t1.tween_property(self, "position", Vector2(559, 257), 1.7).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
