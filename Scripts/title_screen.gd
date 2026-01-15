extends Node2D

@onready var anim: AnimationPlayer = $anim
@onready var play_button: Button = $Menu/Play
@onready var quit_button: Button = $Menu/Quit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Intro")
	$Logo.play("default")
	
	# Enable focus for controller navigation
	play_button.focus_mode = Control.FOCUS_ALL
	quit_button.focus_mode = Control.FOCUS_ALL
	play_button.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	# Handle controller/keyboard input
	if event.is_action_pressed("Up") or event.is_action_pressed("Left"):
		play_button.grab_focus()
	elif event.is_action_pressed("Down") or event.is_action_pressed("Right"):
		quit_button.grab_focus()
	elif event.is_action_pressed("Accept"):
		var focused = get_tree().root.gui_get_focus_owner()
		if focused == play_button:
			_on_play_button_down()
		elif focused == quit_button:
			_on_quit_button_down()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var tween = create_tween()
	if anim_name == "Intro":
		tween.tween_property($Menu, "position", Vector2(-24, 26), 0.5)
	elif anim_name == "Fade":
		LoadScreen.load_scene("res://Scenes/Jobs/Job 1.tscn")
	


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


func _on_website_pressed() -> void:
	OS.shell_open("https://jaytheoff.github.io/uglyduck.github.io/index.html")
