extends CanvasLayer

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		if visible:
			hide_pause_menu()
		else:
			show_pause_menu()

	if event.is_action_pressed("Quit"):
		get_tree().change_scene_to_file("res://Scenes/Title Screen.tscn")

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
