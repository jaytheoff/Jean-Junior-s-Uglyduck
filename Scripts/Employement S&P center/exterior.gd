extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
var follow_player:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player Entered Game")
	_fade_in()
	await get_tree().create_timer(3).timeout
	var tween = create_tween()
	tween.tween_property($Camera2D, "position", Vector2(-222,-83), 6.0)
	await tween.finished
	
	print("Camera tween finished, now following player.")
	follow_player = true

	$CanvasLayer/Fade.hide()
	anim.play("Exterior")

	
	$CanvasLayer/Location.show()
	await get_tree().create_timer(5.0).timeout
	$CanvasLayer/Location.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if follow_player:
		var player = get_node("Player")
		if player:
			$Camera2D.position = player.position
		
func _on_entrance_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player entered the entrance area")
		Enter_Building()

func Enter_Building() -> void:
	$CanvasLayer/Fade.show()
	$CanvasLayer/Fade.color = Color(0, 0, 0, 0)
	var tween = create_tween()

	# animate the fade from transparent to black
	tween.tween_property($CanvasLayer/Fade, "color", Color(0, 0, 0, 1), 3.0)
	await tween.finished

	# switch scene to interior
	get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Interior.tscn")

func _fade_in():
	$CanvasLayer/Fade.show()
	$CanvasLayer/Fade.color = Color(0, 0, 0, 1)
	var tween = create_tween()
	tween.tween_property($CanvasLayer/Fade, "color", Color(0, 0, 0, 0), 3.0)