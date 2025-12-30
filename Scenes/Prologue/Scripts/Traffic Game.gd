extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Fade Out")
	$Background/Building/Mask.modulate = Color.WHITE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Background/Building/Mask, "modulate", Color.TRANSPARENT, 1.0)


func _on_area_2d_body_exited(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Background/Building/Mask, "modulate", Color.WHITE, 1.0)

func _on_player_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Goal"):
		$AnimationPlayer.play("Fade In")
		get_tree().paused = true
