extends Area2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	transform = transform.translated(Vector2(100 * delta, 0))

	if Input.is_action_pressed("Down"):
		pass
	elif Input.is_action_pressed("Up"):
		pass
