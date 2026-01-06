extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	position.y += 200 * delta  # Move the icicle downwards at 200 pixels per second
	if position.y > 600:  # If the icicle goes off-screen (assuming screen height is 600)
		queue_free()  # Remove it from the scene

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player hit by icicle!")
		body._take_damage(3)
		#body.take_damage(10)  # Assuming the player has a take_damage method
		queue_free()  # Remove the icicle after hitting the player
