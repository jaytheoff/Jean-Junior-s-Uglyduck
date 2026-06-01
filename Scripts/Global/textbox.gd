extends CanvasLayer

@onready var _dialogue = $OuterContainer/InnerContainer/Panel/HBoxContainer/Dialogue
@onready var _name = $OuterContainer/Name
@onready var _start_symbol = $OuterContainer/InnerContainer/Panel/HBoxContainer/Start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _show_textbox():
	_start_symbol.text = "*"
	_dialogue.text = ""
	_name.text = ""
	show()

func _hide_textbox():
	_start_symbol.text = "*"
	_dialogue.text = ""
	_name.text = ""
	hide()

func _add_text(text: String, speaker: String) -> void:
	var tween = create_tween()
	_show_textbox()
	_dialogue.text = text
	_dialogue.visible_characters = 0
	_name.text = speaker
	
	
	tween.tween_property(_dialogue, "visible_characters", text.length(), Global.text_scroll_speed)
	await tween.finished
	_start_symbol.text = ">"
	while not Input.is_action_just_pressed("Any"):
		await get_tree().process_frame
	tween.stop()
	_dialogue.visible_characters = text.length()
	
# Public wrapper so other scripts (or a UI manager) can call this
func show_text(text: String, speaker: String) -> void:
	await _add_text(text, speaker)

func hide_text() -> void:
	_hide_textbox()
