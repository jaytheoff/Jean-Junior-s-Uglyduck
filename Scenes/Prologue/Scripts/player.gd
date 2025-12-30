extends CharacterBody2D

var speed: float = 200.0
var jump_velocity: float = -350.0
var jump_count: int = 0

var dash_speed: float = 1000.0
var dash_duration: float = 0.2
var dash_cooldown: float = 0.5
var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0

var crouched: bool = false

# Squash and stretch animation
var scale_y: float = 1.0
var scale_x: float = 1.0
var target_scale_y: float = 1.0
var target_scale_x: float = 1.0
var squash_amount: float = 0.9  # How much to squash (0.7 = 30% compression)
var squash_speed: float = 10.0  # Speed of squash/stretch animation
var stretch_amount: float = 1.1  # How much to stretch when jumping (1.1 = 10% stretch)
var last_direction: float = 1.0  # Track facing direction

func _process(delta: float) -> void:
	# Reset jump count when on the floor.
	if is_on_floor():
		jump_count = 0

	if Input.is_action_pressed("Down") and is_on_floor():
		crouched = true
	else:
		crouched = false

	if crouched:
		$Hurtbox/Normal.disabled = true
		$Hurtbox/Crouched.disabled = false
		$CollisionShape2D.disabled = true  # Disable main collision shape
		$Crouched.disabled = false  # Show crouched sprite when crouching
		target_scale_y = squash_amount  # Start squashing
	else:
		$Hurtbox/Normal.disabled = false
		$Hurtbox/Crouched.disabled = true
		target_scale_y = 1.0  # Return to normal
		$CollisionShape2D.disabled = false  # Enable main collision shape
		$Crouched.disabled = true  # Hide crouched sprite when not crouching
	
	# Smoothly interpolate scale
	scale_y = lerp(scale_y, target_scale_y, squash_speed * delta)
	scale_x = lerp(scale_x, target_scale_x, squash_speed * delta)
	scale.y = scale_y
	scale.x = scale_x

func _physics_process(delta: float) -> void:
	# Update dash timers
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
	
	# Handle dash input
	if Input.is_action_just_pressed("Dash") and not is_dashing and dash_cooldown_timer <= 0:
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown
	
	# Apply gravity always (unless on floor)
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Apply dash movement
	if is_dashing:
		velocity.x = Input.get_axis("Left", "Right") * dash_speed
		# Squash horizontally when dashing
		if velocity.x != 0:
			last_direction = sign(velocity.x)
			target_scale_x = 0.8  # Compress horizontally (20% narrower)
			target_scale_y = stretch_amount  # Stretch vertically
	else:
		# Normal movement
		# Handle jump.
		if Input.is_action_just_pressed("Up") and jump_count < 2:
			jump_count += 1
			velocity.y = jump_velocity
			target_scale_y = stretch_amount  # Stretch when jumping
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * speed
			last_direction = sign(direction)
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		
		# Reset scale when not jumping/dashing and on floor
		if is_on_floor() and velocity.y >= 0:
			target_scale_x = 1.0
			target_scale_y = 1.0
	
	move_and_slide()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Limit"):
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
