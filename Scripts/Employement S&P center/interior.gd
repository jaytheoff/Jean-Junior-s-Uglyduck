extends Node2D

#Camera Variables
var follow:bool = false
var target_position:Vector2

#Player variables
var can_move_player:bool = true

#GameState
enum GAMESTATE {
	Found_Recep,
	Found_Class,
	Found_Prof,
	Found_Job
}

#Game State Variables
var found_recep:bool = GAMESTATE.Found_Recep
var found_class:bool = GAMESTATE.Found_Class
var found_Prof:bool = GAMESTATE.Found_Prof
var found_job:bool = GAMESTATE.Found_Job


func _ready() -> void:
	get_tree().paused = false

	#Game State Variables
	found_recep = false
	found_class = false
	found_Prof = false
	found_job = false
	
	print(Global.current_game_phase)
	$Camera2D.make_current()
	_Camera(1,0,0,0.3)

	if Global.current_game_phase == Global.GamePhase.introduction:
		pass
	else:
		return

func _process(_delta: float) -> void:

	#Player Movement
	if can_move_player:
		var player = get_node_or_null("Player")
		if player: player.speed = 35
		else:
			print("Player does not exist.")
			return 
	else:
		var player = get_node_or_null("Player")
		if player:
			player.speed = 0
		else:
			print("Player does not exist.")
			return
	
	#Check if Follow is true if so then camera follows the player
	match follow:
		true:
			var player = get_node_or_null("Player")
			if player:
				$Camera2D.global_position = player.global_position
			else:
				print("Player does not exist.")
				return
		false:
			return
	

#Camera Function system
func _Camera(room:int, cam_x:float, cam_y:float, speed:float):
	match room:

		#Custom
		0:	
			follow = false
			target_position = Vector2(cam_x, cam_y)
		
		#Lobby
		1:
			follow = false
			target_position = Vector2(-1647, -1091)
		
		#Classroom
		2:
			follow = false 
			target_position = Vector2(-1643, -839)

		#Hallway
		3:
			follow = true
			target_position = Vector2(-1385, -1092)
		
		#Job Listing Room
		4:
			follow = false
			target_position = Vector2(-1361, -851)
		
		#Offices Hallway
		5:
			follow = true
			target_position = Vector2(-1025, -851)

	var tween = create_tween()
	tween.tween_property($Camera2D, "global_position", target_position, speed)
	await tween.finished
	print(str($Camera2D.global_position.x)+str($Camera2D.global_position.y))

	print(room)
	print(follow)

#Teleporing Player function system		
func _teleport_player(Dest_x:float, Dest_y:float):
	var player = get_node_or_null("Player")
	if player:
		player.global_position = Vector2(Dest_x, Dest_y)
	else:
		print("Player does not exist.")
		return

#Signals to move player inbetween Rooms
func _on_classroom_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_Camera(2,0,0,0.3)
		_teleport_player(-1648, -889)

func _on_hallway_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_Camera(3,0,0,0.3)
		_teleport_player(-1402, -1095)

func _on_class_to_lob_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_Camera(1,0,0,0.3)
		_teleport_player(-1645, -1061)

func _on_hall_to_lob_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_Camera(1,0,0,0.3)
		_teleport_player(-1593, -1091)

func _on_listings_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_Camera(4,0,0,0.3)
		_teleport_player(-1348, -886)

func _on_list_to_hall_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_Camera(3,0,0,0.3)
		_teleport_player(-1351, -1058)

func _on_offices_hall_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_Camera(5,0,0,0.3)
		_teleport_player(-1025, -851)

func _on_office_to_hall_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_Camera(3,0,0,0.3)
		_teleport_player(-1078, -1058)


		
