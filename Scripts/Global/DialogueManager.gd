@tool
extends Node

@export var textbox_name: String = "GlobalTextBox"

@onready var TextboxScene := preload("res://Scenes/Textbox.tscn")
var textbox: Node = null

func _ready() -> void:
    # Instantiate the TextBox scene and add it to the root so it's available globally
    textbox = TextboxScene.instantiate()
    get_tree().get_root().add_child.call_deferred(textbox)
    textbox.name = textbox_name
    textbox.hide()

func show_text(text: String, speaker: String = "") -> void:
    if not textbox:
        push_error("UIManager: textbox not ready")
        return
    if textbox.has_method("show_text"):
        await textbox.call("show_text", text, speaker)
    elif textbox.has_method("_add_text"):
        await textbox.call("_add_text", text, speaker)
    else:
        push_error("UIManager: textbox missing show_text/_add_text methods")

func hide_text() -> void:
    if textbox and textbox.has_method("_hide_textbox"):
        textbox.call("_hide_textbox")
    elif textbox:
        textbox.hide()
