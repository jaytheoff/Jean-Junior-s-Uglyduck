extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		await Dialogue.show_text("Hi There, Welcome to the employement Research and support center!", "Receptionist")
		await Dialogue.show_text("Anyway How could i help you?", "Receptionist")
		var choice = await Dialogue.ask_choices(["suck my duck", "what is this place?"])
		print("Player chose: " + str(choice))

		if choice == 0:
			await Dialogue.show_text("I don't think i can do that for you", "Receptionist")
		elif choice == 1:
			await Dialogue.show_text("This is a place where you can find jobs and get help with your career.", "Receptionist")
