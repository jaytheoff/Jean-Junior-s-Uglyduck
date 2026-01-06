extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Warning.show
	$ColorRect.hide()
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(0.6).timeout
	_beam_Flash()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _beam_Flash():
	$Warning.hide()
	$ColorRect.show()
	$CollisionShape2D.disabled = false
	await get_tree().create_timer(1.0).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player got cooked!")
		body._take_damage(25)
