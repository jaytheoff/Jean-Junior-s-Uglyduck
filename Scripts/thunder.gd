extends Area2D

signal shock

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("warning")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player got cooked!")
		body._take_damage(100)


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "warning":
		$AnimatedSprite2D.play("shock")
		$CollisionShape2D.disabled = false
		print("Shockwave activated!")
		await $AnimatedSprite2D.animation_finished
		queue_free()




func _on_shock() -> void:
	$shock.play()
