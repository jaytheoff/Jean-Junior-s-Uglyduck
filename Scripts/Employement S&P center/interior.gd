extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true

	var tween = create_tween()
	$CanvasLayer/Fade.show()
	$CanvasLayer/Fade.color = Color.BLACK
	tween.tween_property($CanvasLayer/Fade, "color", Color(0, 0, 0, 0), 1.0)

	tween.tween_property($Camera2D, "position", Vector2(-1641,-1096), 1.0)
	await tween.finished
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_lobby_visible_screen_entered() -> void:
	$Lobby.show()

func _on_lobby_visible_screen_exited() -> void:
	$Lobby.hide()
	print("Player no longer in lobby.")
