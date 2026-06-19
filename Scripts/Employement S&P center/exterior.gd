extends Node2D

signal player_movable
signal player_immovable

@onready var anim: AnimationPlayer = $AnimationPlayer
var follow_player:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	match Global.GamePhase:
		"post_prologue":
			
			# Disable Player
			emit_signal("player_immovable")
			anim.play("Fade out")
			
			#Move Camera to player
			var tween = create_tween()
			tween.tween_property($Camera2D, "position", Vector2($Player.position.x, $Player.position.y), 6.0)
			await tween.finished
			follow_player = true
			anim.play("Exterior")
			
			#Player Does Dialogue
			await Dialogue.show_text("Finally.. Today is the day my life will change..", "Uglyduck (YOU)")
			await Dialogue.show_text("Hopefully everything things goes right and i get hired..", "Uglyduck (YOU)")
			Dialogue.hide_text()

			#after animation of camera moving player is able to move againnnn twin
			emit_signal("player_movable")

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
	
	anim.play("Fade in")
	await anim.animation_finished

	# switch scene to interior
	get_tree().change_scene_to_file("res://Scenes/Employement Support Center/Interior.tscn")
