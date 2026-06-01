extends Node2D

signal player_movable
signal player_immovable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Scene begins paused to allow camera animation to kick in
	get_tree().paused = true
	
	var tween = create_tween()

	#Fade Animation Block Code
	$CanvasLayer/Fade.show()
	$CanvasLayer/Fade.color = Color.BLACK
	tween.tween_property($CanvasLayer/Fade, "color", Color(0, 0, 0, 0), 1.0)
	
	#Camera Moves to Lobby Position
	tween.tween_property($Camera2D, "position", Vector2(-1647,-1092), 1.0)
	
	await tween.finished

	# Scene Unpaused
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Exterior.tscn")


func _on_classroom_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1647,-844), 1.0)
		$Player.position = Vector2(-1646,-872)

func _on_return_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1647,-1092), 1.0)
		$Player.position = Vector2(-1646,-1066)

func _on_receptionist_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# Disables Player to move during dialogues
		emit_signal("player_immovable")
		
		# Dialogue block code
		await Dialogue.show_text("Hey There!, Welcome to the Employment Support Center", "Receptionist")
		await Dialogue.show_text("Hello, So I'm trying to find a J-O-B.", "You")
		await Dialogue.show_text("Hmm... You don't look familiar, Is it your first time here?, Are you new by any chance?", "Receptionist")
		await Dialogue.show_text("Yeah I'm new, i also don't know where to go..", "You")
		await Dialogue.show_text("Alright.. SO I recommend you go check out the classroom they teach you how to get employed, which is eaxctly how i'm here today.", "Receptionist")
		await Dialogue.show_text("Where's this 'classroom' your talking about?", "You")
		await Dialogue.show_text("It's right behind you, down there.", "Receptionist")
		Dialogue.hide_text()

		# Re-enables Player Movement
		emit_signal("player_movable")

		# Player Can no longer interact with the receptionist after the first interaction
		$NPCs/Receptionist/CollisionShape2D.disabled = true

func _wait_for_accept() -> void:
	# Ignore any Accept button already pressed before the dialogue appears.
	while Input.is_action_pressed("Accept"):
		await get_tree().process_frame

	# Wait for a fresh press, then release.
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("Accept"):
			while Input.is_action_pressed("Accept"):
				await get_tree().process_frame
			return


func _on_board_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		#Disables Player Movement
		emit_signal("player_immovable")
		
		#Dialogue Block Code
		await Dialogue.show_text("This is the Job Board (It's actually not a board, you can check for logs and updates here.)", "Developer Note")
		await Dialogue.show_text("Class is dismissed today, if you need help with anything please come find me either in the job listing room or my office. -Professor Pop", "")
		Dialogue.hide_text()
		
		#Re-enables Player Movement
		emit_signal("player_movable")


func _on_hallway_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1647,-1092), 1.0)
		$Player.position = Vector2(-1401,-1095)
