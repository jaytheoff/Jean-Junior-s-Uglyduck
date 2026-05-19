extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true

	var tween = create_tween()
	$CanvasLayer/Fade.show()
	$CanvasLayer/Fade.color = Color.BLACK
	tween.tween_property($CanvasLayer/Fade, "color", Color(0, 0, 0, 0), 1.0)

	tween.tween_property($Camera2D, "position", Vector2(-1647,-1092), 1.0)
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


func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Exterior.tscn")


func _on_classroom_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1647,-1092), 1.0)

func _on_return_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1647,-1092), 1.0)
