extends CharacterBody2D

var speed = 200

func _process(delta):
	$Plane.play("Idle")
	$Sprite.play("Idle")
func _physics_process(delta: float) -> void:	
	var direction = Vector2.ZERO
	if Input.is_action_pressed("Left"):
		direction.x -= 1
		$Sprite.flip_h = true
	if Input.is_action_pressed("Right"):
		direction.x += 1
		$Sprite.flip_h = false
	if Input.is_action_pressed("Up"):
		direction.y -= 1
	if Input.is_action_pressed("Down"):
		direction.y += 1

	velocity = direction * speed
	move_and_slide()