extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Fade.visible = true
	get_tree().paused = true
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Debug Screen.dialogue"))
	
	await DialogueManager.dialogue_ended
	get_tree().paused = false
	$Fade.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Quit"):
		get_tree().change_scene_to_file("Scenes/Title Screen.tscn")
func _on_cheats_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global_Player_Variables.casino_cheats_enabled = true
		$VBoxContainer/Cheats.text = "Casino Cheats: Enabled"
		print("Casino Cheats Enabled")
	else:
		Global_Player_Variables.casino_cheats_enabled = false
		$VBoxContainer/Cheats.text = "Casino Cheats: Disabled"
		print("Casino Cheats Disabled")


func _on_debug_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_money_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
