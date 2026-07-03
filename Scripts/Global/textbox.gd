extends CanvasLayer

signal SELECTED(index)

@onready var choice_list = $"OuterContainer/InnerContainer/Panel/Choice List"
@onready var choice_prefab = $"OuterContainer/InnerContainer/Panel/Choice List/Choice Button"

var _start_symbol: Label
var _dialogue: RichTextLabel
var _name: Label

var choices:Array = []:
	set(value):
		choices = value
		if is_inside_tree():
			_init_buttons()

func _ready() -> void:
	_start_symbol = get_node_or_null("OuterContainer/InnerContainer/Panel/HBoxContainer/Start")		# Label
	_dialogue = get_node_or_null("OuterContainer/InnerContainer/Panel/HBoxContainer/Dialogue")	# RichTextLabel
	_name = get_node_or_null("OuterContainer/Name")

	if not _start_symbol or not _dialogue or not _name:
		push_error("Textbox scene is missing one or more expected nodes: Start, Dialogue, or Name")
		return
	
	_init_buttons()


#Dialogue Functions
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

func ask_choices(options: Array) -> int:
	choices = options
	_show_textbox()
	_init_buttons()

	var selected_index = await self.SELECTED
	if selected_index is Array:
		selected_index = selected_index[0]

	_hide_textbox()
	return int(selected_index)

#Choice Functions
func onChoice(choice_index):
	emit_signal("SELECTED", choice_index)
	print("Choice selected: " + str(choice_index))
	_hide_textbox()

func _init_buttons():
	if not choice_list:
		return

	while choice_list.get_child_count() > 0:
		var button = choice_list.get_child(0)
		choice_list.remove_child(button)
		button.queue_free()
	
	for choice_index in range(choices.size()):
		var button = choice_prefab.duplicate()
		choice_list.add_child(button)
		button.text = choices[choice_index]
		button.pressed.connect(onChoice.bind(choice_index))
