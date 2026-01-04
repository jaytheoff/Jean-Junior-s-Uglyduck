extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= 200 * delta  # Move the balloon like fucking up at 200 pixels per second
	if position.y < -100:  # If the balloon goes off-screen 
		queue_free()  # Remove it from the scene


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player_body = body as CharacterBody2D
		player_body.score += 10  # Increase the player's score by 1
		queue_free()  # Remove the balloon from the scene
