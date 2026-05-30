@tool

extends Node


var TextboxScene := preload("res://Scenes/Textbox.tscn")
var textbox: Node = null

func _ready() -> void:
    # Instantiate the TextBox scene and add it to the root so it's available globally
    textbox = TextboxScene.instantiate()
    get_tree().get_root().add_child.call_deferred(textbox)
    textbox.name = "GlobalTextBox"
    textbox.hide()

func show_text(text: String) -> void:
    if not textbox:
        push_error("UIManager: textbox not ready")
        return
    if textbox.has_method("show_text"):
        textbox.call("show_text", text)
    else:
        textbox.call("_add_text", text)

func hide_text() -> void:
    if textbox and textbox.has_method("_hide_textbox"):
        textbox.call("_hide_textbox")
    elif textbox:
        textbox.hide()
