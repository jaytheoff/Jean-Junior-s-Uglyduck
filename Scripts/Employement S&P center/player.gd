extends CharacterBody2D

@export var speed = 36

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

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
