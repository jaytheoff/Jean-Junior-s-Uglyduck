extends CanvasLayer

@onready var anim : AnimationPlayer = $AnimationPlayer

enum STATE {
	not_playing_intro,
	is_playing_intro,
	is_ending_intro
}

var not_playing_intro : bool = true
var is_ending_intro : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_game_phase = Global.GamePhase.introduction
	
	anim.play("Prologue")


func _end():
	Global.current_game_phase = Global.GamePhase.post_prologue
	get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Exterior.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Prologue":
		_end()


func _on_skip_pressed() -> void:
	_end()
