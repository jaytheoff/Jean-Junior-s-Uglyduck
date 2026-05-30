extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	var t1 = create_tween()

	t1.tween_property($Fade, "modulate", Color.TRANSPARENT, 4.0)
	await t1.finished
	$Fade.queue_free()
	Dialogue.show_text("Once upon a time, in a world much like our own, there lived a duck named Quackers.")	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Debug Key"):
		get_tree().change_scene_to_file("Scenes/Debug Select.tscn")
func _on_socials_pressed() -> void:
	$Menu.hide()
	$Socials.show()
	$click.play()


func _on_return_pressed() -> void:
	$Menu.show()
	$Socials.hide()
	$click.play()
	


func _on_discord_pressed() -> void:
	$click.play()


func _on_website_pressed() -> void:
	$click.play()


func _on_github_pressed() -> void:
	$click.play()


func _on_start_pressed() -> void:
	$click.play()
	get_tree().change_scene_to_file("res://Scenes/Prologue.tscn")
