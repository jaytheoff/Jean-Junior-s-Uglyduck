extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Intro")
	$Logo.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var tween = create_tween()
	if anim_name == "Intro":
		tween.tween_property($Menu, "position", Vector2(-24, 26), 0.5)
	elif anim_name == "Fade":
		get_tree().change_scene_to_file("Scenes/Job Select.tscn")


func _on_play_button_down() -> void:
	anim.play("Fade")
	


func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_discord_pressed() -> void:
	OS.shell_open("https://discord.gg/r7VMt2cBCV")

func _on_youtube_pressed() -> void:
	OS.shell_open("https://www.youtube.com/@JeanJuniorJams")


func _on_github_pressed() -> void:
	OS.shell_open("https://github.com/jaytheoff/uglyduck")
