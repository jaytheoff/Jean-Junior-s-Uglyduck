extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var dialogue = $CanvasLayer/Dialogue/Text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Dialogue.hide()
	$CanvasLayer/Fade.modulate = Color.WHITE
	var t1 = create_tween()

	t1.tween_property($CanvasLayer/Fade, "modulate", Color.TRANSPARENT, 2.0)
	await t1.finished
	$CanvasLayer/Fade.hide()

	anim.play("Scene 1")

	set_text("It was a beatiful morning...")
	await get_tree().create_timer(3).timeout
	set_text("The sun was shining...")
	await get_tree().create_timer(3).timeout
	set_text("Birds were singing...")
	await get_tree().create_timer(3).timeout
	set_text("And the uglyduck was not gonna be very happy today...")

	anim.play("Scene 2")
	await get_tree().create_timer(3).timeout
	set_text("By the way.., Uglyduck was supposed to be at work a few hours ago..")
	await get_tree().create_timer(3).timeout
	set_text("He is very late...")
	await get_tree().create_timer(3).timeout
	
	anim.play("Scene 3")
	await get_tree().create_timer(3).timeout
	set_text("His Boss IS calling.., that cant be good")
	await get_tree().create_timer(3).timeout
	set_text("So he Answers the phone...")
	await get_tree().create_timer(3).timeout

	anim.play("Scene 4")
	await get_tree().create_timer(3).timeout
	set_text("Uglyduck: Hello?")
	await get_tree().create_timer(3).timeout
	set_text("Boss: Where are you? You are late again!")
	await get_tree().create_timer(3).timeout

	anim.play("Outro")
	set_text("Uglyduck: OH shit..")

	await get_tree().create_timer(8).timeout
	_next()

func set_text(text: String) -> void:
	
	dialogue.text = text
	$CanvasLayer/Dialogue.show()
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Dialogue.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_skip_pressed() -> void:
	$Skip.play()
	_next()
	
func _next():
	$CanvasLayer/Skip.hide()
	$CanvasLayer/Fade.show()

	$CanvasLayer/Fade.modulate = Color.TRANSPARENT
	var t1 = create_tween()

	t1.tween_property($CanvasLayer/Fade, "modulate", Color.WHITE, 2.0)
	await t1.finished
	get_tree().change_scene_to_file("res://Scenes/Car Rush.tscn")
