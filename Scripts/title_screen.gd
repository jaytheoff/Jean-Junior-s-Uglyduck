extends CanvasLayer

@onready var anim : AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	# Fade In Animation
	anim.play("Fade in")
	await anim.animation_finished
	anim.play("Loop")

	$Menu/StartButton.grab_focus(false)
