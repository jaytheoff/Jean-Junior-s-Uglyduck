extends Node2D

@onready var anim : AnimationPlayer = $AnimationPlayer
var room = 1
var cam_follow: bool = false

enum Completed_Quests {
	None,
	Talked_to_receptionist,
	Find_Professer,
	Get_Quests,
}

var none:bool = Completed_Quests.None
var found_professer: bool = Completed_Quests.Find_Professer
var got_quests: bool = Completed_Quests.Get_Quests
var talked_to_receptionist: bool = Completed_Quests.Talked_to_receptionist

signal player_movable
signal player_immovable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.position = Vector2(-1931.0,-1091.0)
	anim.play("Fade out")
	found_professer = false
	got_quests = false
	talked_to_receptionist = false
	none = true

	get_tree().paused = false
	
	var tween = create_tween()
	tween.tween_property($Camera2D, "position", Vector2(-1647,-1092), 1.0)

	if Global.current_game_phase == Global.GamePhase.post_prologue:
		$Player.position = Vector2(-1696.0,-1099.0)
	else:
		return
	
	#Re-Position Camera to lobby
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if cam_follow:
		var player = get_node("Player")
		if player:
			$Camera2D.position = Vector2( $Player.position.x , $Player.position.y )

#When Player goes into classroom Door
func _on_classroom_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		room = 2
		_Move_Camera()
		$Player.position = Vector2(-1646, -877)

#Receptionist Dialogue
func _on_receptionist_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Global.current_game_phase == Global.GamePhase.post_prologue:
		if not found_professer and not got_quests and none and not talked_to_receptionist:
		
			# Disables Player to move during dialogues
			emit_signal("player_immovable")

			
			# Dialogue block code
			await Dialogue.show_text("Hey There!, Welcome to the Employment Support Center", "Receptionist")
			await Dialogue.show_text("Hello, So I'm trying to find a J-O-B.", "Uglyduck (You)")
			await Dialogue.show_text("Hmm... You don't look familiar, Is it your first time here?, Are you new by any chance?", "Receptionist")
			await Dialogue.show_text("Yeah I'm new, i also don't know where to go..", "Uglyduck (You)")
			await Dialogue.show_text("Alright.. SO I recommend you go check out the classroom they teach you how to get employed, which is eaxctly how i'm here today.", "Receptionist")
			await Dialogue.show_text("Where's this 'classroom' your talking about?", "Uglyduck (You)")
			await Dialogue.show_text("It's right behind you, down there.", "Receptionist")
			Dialogue.hide_text()

			# Re-enables Player Movement
			emit_signal("player_movable")

			# Player Can no longer interact with the receptionist after the first interaction
			talked_to_receptionist = true
			none = false
			return
		
		elif talked_to_receptionist and not found_professer and not got_quests and not none:
			emit_signal("player_immovable")
			
			await Dialogue.show_text("Can't you catch a clue?, I'm clearly busy!, Go and find the professor!", "Receptionist")
			Dialogue.hide_text()
			
			emit_signal("player_movable")
			return

		elif talked_to_receptionist and found_professer and not got_quests and not none:
			emit_signal("player_immovable")
			await Dialogue.show_text("Seriously go talk to the professor if you want a job.", "Receptionist")
			Dialogue.hide_text()
			emit_signal("player_movable")
		
		elif talked_to_receptionist and found_professer and got_quests and not none:
			emit_signal("player_immovable")
			await Dialogue.show_text("Buddy I bet the professor Already gave you a damn job, FUCK OFF!!", "Receptionist")
			Dialogue.hide_text()
			emit_signal("player_movable")

#Chalkboard Dialogue
func _on_board_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		#Disables Player Movement
		emit_signal("player_immovable")
		
		#Dialogue Block Code
		await Dialogue.show_text("This is the Job Board (It's actually not a board, you can check for logs and updates here.)", "Developer Note")
		if found_professer and not got_quests:
			await Dialogue.show_text("I should probably go check on Professor Pop, maybe he has some quests for me..", "Uglyduck (You)")
			Dialogue.hide_text()
			
		elif found_professer and got_quests:
			await Dialogue.show_text("What the fuck AM I DOING HERE?, Professer pop gave me a fucking quest, Maybe the player should have a clue and not go to the bathroom", "Uglyduck (You)")
			Dialogue.hide_text()
		
		elif not found_professer and not got_quests and not none: 
			await Dialogue.show_text("Class is dismissed today, if you need help with anything please come find me either in the job listing room or my office. -Professor Pop", "")
			await Dialogue.show_text("Guess the professer is not here.., I should check else where..", "Uglyduck (You)")
			Dialogue.hide_text()
		Dialogue.hide_text()
		
		
		#Re-enables Player Movement
		emit_signal("player_movable")

#same as classroom but for hallway
func _on_hallway_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		room = 3
		_Move_Camera()
		$Player.position = Vector2(-1401,-1095)

#Function called to use when displacing the camera elsewhere.
func _Move_Camera():

	#Lobby
	if room == 1:
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1647,-1092), 1.0)
		cam_follow = false
		
	
	#Classroom
	elif room == 2:
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1647,-838), 1.0)
		cam_follow = false
		

	#Hallway
	elif room == 3:
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2( $Player.position.x , $Player.position.y ), 1.0)
		$Camera2D.position = Vector2( $Player.position.x , $Player.position.y )
		cam_follow = true

	#Job Listings Room
	elif room == 4:
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1359,-846), 1.0)
		cam_follow = false

	#Offices Hallway
	elif room == 5:
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-1026, -876), 1.0)
		cam_follow = true


func _on_listings_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Player.position = Vector2(-1351, -884)


func _on_bathroom_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if found_professer and not got_quests and not none:
			emit_signal("player_immovable")
			await Dialogue.show_text("I should go check out professer pop's office", "Uglyduck (You)")
			Dialogue.hide_text()
			emit_signal("player_movable")
		elif not found_professer and not got_quests and not none:
			emit_signal("player_immovable")
			await Dialogue.show_text("Huh.. A bathroom?", "Uglyduck (You)")
			await Dialogue.show_text("Whatever, I should probably look for Professor Pop First.", "Uglyduck (You)")
			Dialogue.hide_text()
			emit_signal("player_movable")
		elif found_professer and got_quests and not none:
			emit_signal("player_immovable")
			anim.play("Fade in")
			get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Bathroom.tscn")


func _on_job_pinboard_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if talked_to_receptionist and not found_professer and not got_quests and not none:
			emit_signal("player_immovable")
			await Dialogue.show_text("Woah, A Job Listing board.., Thats Conveinent", "Uglyduck (You)")
			await Dialogue.show_text("But I should probably look for Professor Pop First.", "Uglyduck (You)")
			Dialogue.hide_text()
			emit_signal("player_movable")

		elif talked_to_receptionist and found_professer and not got_quests and not none:
			emit_signal("player_immovable")
			await Dialogue.show_text("I should probably go check on Professor Pop, maybe he has some quests for me..", "Uglyduck (You)")
			Dialogue.hide_text()
			emit_signal("player_movable")
		
		elif talked_to_receptionist and found_professer and got_quests and not none:
			emit_signal("player_immovable")
			await Dialogue.show_text("What Am I doing here?, The Professor already gave a damn task, maybe the player can catch a clue and go to the bathroom.. maybe", "Uglyduck (You)")
			Dialogue.hide_text()
			emit_signal("player_movable")
		

func _on_offices_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		room = 5
		_Move_Camera()
		$Player.position = Vector2(-1023, -868)


func _on_hallway_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		room = 3
		_Move_Camera()
		$Player.position = Vector2(-1355, -1066)


func _on_professor_pop_body_entered(body: Node2D) -> void:
	if not found_professer and not got_quests and not none and talked_to_receptionist and body.is_in_group("Player"):
		
		
		emit_signal("player_immovable")
		await Dialogue.show_text("Excuse me, Have you seen any professors around?", "Uglyduck (You)")
		await Dialogue.show_text("Well I am a professor myself.", "???")
		await Dialogue.show_text("Professor.. Who?", "Uglyduck (You)")
		await Dialogue.show_text("I am Professor Pop.", "Professor Pop")
		await Dialogue.show_text("Oh well, I have been looking for you, I heard you might be able to help me get some work.", "Uglyduck (You)")
		await Dialogue.show_text("Please come meet me in my office.", "Professor Pop")
		Dialogue.hide_text()

		anim.play("Fade in")
		await get_tree().create_timer(2).timeout
		anim.play("Fade out")
		found_professer = true

		emit_signal("player_movable")
		
	elif not found_professer and not got_quests and none and not talked_to_receptionist and body.is_in_group("Player"):
		emit_signal("player_immovable")
		await Dialogue.show_text("Sure Love my job... (Why do i keep doing this..)", "???")
		emit_signal("player_movable")

func _on_lobby_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Entered Lobby")
		room = 1
		_Move_Camera()
		$Player.position = Vector2(-1646.0,-1064.0)
		

func _on_hallway_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		room = 3
		_Move_Camera()
		$Player.position = Vector2(-1081, -1078)


func _on_unemployed_chud_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		if not found_professer and not got_quests and not none and talked_to_receptionist:
			emit_signal("player_immovable")
			await Dialogue.show_text("*Singing* I'm a chud, I'm a fat little chud", "Unemployed Chud")
			await Dialogue.show_text("Uh Sorry to interrupt your singing, I got a question for ya", "Uglyduck (You)")
			await Dialogue.show_text("What do you want", "Unemployed Chud")
			await Dialogue.show_text("Have ya seen any professers around?", "Uglyduck (You)")
			await Dialogue.show_text("HELL NAW!, also i'm larping employement just don't tell anybody", "Unemployed Chud")
			await Dialogue.show_text("Ok...?", "Uglyduck (You)")
			Dialogue.hide_text()
			emit_signal("player_movable")
		
		elif found_professer and not got_quests and not none and talked_to_receptionist:
			emit_signal("player_immovable")
			await Dialogue.show_text("WHat do yOu Waaant Dammnnit, Haven't you seen the professer leave me alone! let me larp!", "Unemployed Chud")
			Dialogue.hide_text()
			emit_signal("player_movable")
		
		elif found_professer and got_quests and not none and talked_to_receptionist:
			emit_signal("player_immovable")
			await Dialogue.show_text("Don't talk to me do your quests.", "Unemployed Chud")
			Dialogue.hide_text()
			emit_signal("player_movable")


func _on_open_office_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if not found_professer and not got_quests and not none and talked_to_receptionist:
			emit_signal("player_immovable")
			await Dialogue.show_text("*Knock* *Knock*", "Uglyduck (You)")
			await Dialogue.show_text("Hello? Is anyone in here?", "Uglyduck (You)")
			await Dialogue.show_text("It's no use the door is locked..", "Uglyduck (You)")
			Dialogue.hide_text()
			emit_signal("player_movable")
		
		elif found_professer and not got_quests and not none and talked_to_receptionist:
			return
		
		elif found_professer and got_quests and not none and talked_to_receptionist:
			emit_signal("player_immovable")
			await Dialogue.show_text("What am i doing here, the professer gave me a quest!, maybe the player should get a clue and check the bathroom.. just maybe","Uglyduck (You)")
			Dialogue.hide_text()
			emit_signal("player_movable")


func _on_lobby_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		room = 1
		_Move_Camera()
		$Player.position = Vector2(-1597,-1093.0)
