extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Global.current_game_phase = Global.GamePhase.cutscene
	anim.play("Prologue")

func _finish():
	get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Exterior.tscn")


func _on_skip_pressed() -> void:
	$Sounds/Skip.play()
	get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Exterior.tscn")
