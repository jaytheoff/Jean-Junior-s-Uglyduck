extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$warning.show
	$Sprite2D.hide()
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(0.5).timeout
	_beam_Flash()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _beam_Flash():
	$warning.hide()
	$Sprite2D.show()
	$CollisionShape2D.disabled = false
	await get_tree().create_timer(1.0).timeout
	queue_free()