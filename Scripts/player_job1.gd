extends CharacterBody2D

var score: int = 0
@export var speed: float = 150.0
@export var HP: int = 100

@export var dash_speed: float = 325.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.5
@export var is_dashing: bool = false
@export var dash_timer: float = 0.0
@export var dash_cooldown_timer: float = 0.0
#i know your looking whoever you are, yes this is edited also please GET THE OFF MY SCRIPTS!
func _process(delta):
	
	$Plane.play("Idle")
	$Sprite.play("Idle")


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	# Update dash timers
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
	
	# Handle dash input and store dash direction
	if Input.is_action_just_pressed("Dash") and not is_dashing and dash_cooldown_timer <= 0:
		var dash_direction = Vector2.ZERO
		if Input.is_action_pressed("Left"):
			dash_direction.x -= 1
		if Input.is_action_pressed("Right"):
			dash_direction.x += 1
		if Input.is_action_pressed("Up"):
			dash_direction.y -= 1
		if Input.is_action_pressed("Down"):
			dash_direction.y += 1
		
		if dash_direction != Vector2.ZERO:
			dash_direction = dash_direction.normalized()
			velocity = dash_direction * dash_speed
			is_dashing = true
			dash_timer = dash_duration
			dash_cooldown_timer = dash_cooldown
	
	# Only process normal movement when not dashing
	if not is_dashing:
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
		
		velocity = direction.normalized() * speed
	move_and_slide()

