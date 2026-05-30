extends CanvasLayer

@onready var _dialogue = $OuterContainer/InnerContainer/Panel/HBoxContainer/Dialogue
@onready var _name = $OuterContainer/Name
@onready var _start_symbol = $OuterContainer/InnerContainer/Panel/HBoxContainer/Start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_add_text("Hello, World!")

func _show_textbox():
	_start_symbol.text = "*"
	_dialogue.text = ""
	_name.text = ""
	show()

func _hide_textbox():
	hide()

func _add_text(text: String):
	var tween = create_tween()
	_show_textbox()
	_dialogue.text = text
	_dialogue.visible_characters = 0
	_name.text = "Narrator"
	
	
	tween.tween_property(_dialogue, "visible_characters", text.length(), 0.5)
	await tween.finished
	_start_symbol.text = ">"

# Public wrapper so other scripts (or a UI manager) can call this
func show_text(text: String) -> void:
	_add_text(text)

func hide_text() -> void:
	_hide_textbox()
