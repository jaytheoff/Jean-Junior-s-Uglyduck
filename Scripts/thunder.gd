extends Area2D

signal shock

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("warning")
	await $AnimatedSprite2D.animation_finished
	emit_signal("shock")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player got cooked!")
		body._take_damage(25)


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "warning":
		emit_signal("shock")
	if $AnimatedSprite2D.animation == "shock":
		await $AnimatedSprite2D.animation_finished
		queue_free()



func _on_shock() -> void:
	$AnimatedSprite2D.play("shock")
	$CollisionShape2D.disabled = false

