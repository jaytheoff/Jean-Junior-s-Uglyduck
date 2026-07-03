extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var speed = 36
@export var dir:String = "Side"
@export var is_walking:bool = false

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

func _process(delta: float) -> void:

	if Input.is_action_pressed("Left"):
		dir = "Left"
		$AnimatedSprite2D.flip_h = false
		is_walking = true

	elif Input.is_action_pressed("Right"):
		dir = "Right"
		$AnimatedSprite2D.flip_h = true
		is_walking = true

	elif Input.is_action_pressed("Up"):
		dir = "Up"
		is_walking = true

	elif Input.is_action_pressed("Down"):
		dir = "Down"
		is_walking = true
	
	elif not Input.is_action_pressed("Down") and not Input.is_action_pressed("Up") and not Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		is_walking = false

#Play Player's Walking Animation
	match dir:
		"Left":
			if is_walking:
				anim.play("Walk_Side")
			else:
				anim.play("Idle_Side")
		"Right":
			if is_walking:
				anim.play("Walk_Side")
			else:
				anim.play("Idle_Side")
		"Up":
			if is_walking:
				anim.play("Walk_Back")
			else:
				anim.play("Idle_Back")
		"Down":
			if is_walking:
				anim.play("Walk_Front")
			else:
				anim.play("Idle_Front")


func _physics_process(_delta):
	get_input()
	move_and_slide()
func _on_exterior_player_movable() -> void:
	speed = 36
func _on_interior_player_immovable() -> void:
	speed = 0
func _on_interior_player_movable() -> void:
	speed = 36
func _on_exterior_player_immovable() -> void:
	speed = 0
func _on_bathroom_player_immovable() -> void:
	speed = 0
func _on_bathroom_player_movable() -> void:
	speed = 36
