extends Node2D

signal player_movable
signal player_immovable

@onready var anim: AnimationPlayer = $AnimationPlayer
var follow_player:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Disable Player
	emit_signal("player_immovable")

	#let fade in animation happen
	_fade_in()
	await get_tree().create_timer(3).timeout

	#Move Camera to player
	var tween = create_tween()
	tween.tween_property($Camera2D, "position", Vector2($Player.position.x, $Player.position.y), 6.0)

	await tween.finished
	#after animation of camera moving player is able to move againnnn twin
	emit_signal("player_movable")
	
	print("Camera tween finished, now following player.")
	follow_player = true

	#hide fade
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
	emit_signal("player_immovable")
	
	$CanvasLayer/Fade.show()
	$CanvasLayer/Fade.color = Color(0, 0, 0, 0)
	var tween = create_tween()

	# animate the fade from transparent to black
	tween.tween_property($CanvasLayer/Fade, "color", Color(0, 0, 0, 1), 3.0)
	await tween.finished

	# switch scene to interior
	get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Interior.tscn")

func _fade_in():
	# Fade In Black to transparent animation block
	$CanvasLayer/Fade.show()
	$CanvasLayer/Fade.color = Color(0, 0, 0, 1)
	var tween = create_tween()
	tween.tween_property($CanvasLayer/Fade, "color", Color(0, 0, 0, 0), 3.0)
