extends Node2D
@onready var http_request: HTTPRequest = $HTTPRequest
@onready var anim: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Fade.hide()
	anim.play("Exterior")

	$CanvasLayer/Location.show()
	await get_tree().create_timer(5.0).timeout
	$CanvasLayer/Location.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_entrance_body_entered(body: CharacterBody2D) -> void:
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
