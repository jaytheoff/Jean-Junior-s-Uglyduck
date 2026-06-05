extends Node2D

@onready var anim : AnimationPlayer = $AnimationPlayer

signal player_immovable
signal player_movable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("player_immovable")
	anim.play("Fade out")
	emit_signal("player_movable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_blow_dryer_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("player_immovable")
		await Dialogue.show_text("Huh, A blow dryer.... ", "Uglduck (YOU)")
		await Dialogue.show_text("Wait a minute it's a paper roll machine!?", "Uglyduck (YOU)")
		Dialogue.hide_text()
		emit_signal("player_movable")

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("player_immovable")
		await Dialogue.show_text("I should probably go and complete my tasks in the bathroom first.." , "Uglyduck (YOU)")
		Dialogue.hide_text()
		emit_signal("player_movable")


func _on_toliet_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("player_immovable")
		await Dialogue.show_text("Alright this should be the clogged toilet. I'll just take a closer inspection." , "Uglyduck (YOU)")
		Dialogue.hide_text()
		emit_signal("player_movable")


func _on_toliet_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("player_immovable")
		await Dialogue.show_text("This is the first toilet, it seems to be working fine." , "Uglyduck (YOU)")
		Dialogue.hide_text()
		emit_signal("player_movable")
