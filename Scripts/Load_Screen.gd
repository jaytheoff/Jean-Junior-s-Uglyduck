extends CanvasLayer

@onready var anim : AnimationPlayer = $AnimationPlayer

var message = [
	"Jus Hold on gng",
	"U got this fr",
	"Stay focused!",
	"If ts taking long, report the bug",
	"If ts long, go outside or sum",
	"fun fact: duck are omnivores",
	"Did you know? ducks have waterproof feathers",
	"oh yeah you should watch my youtube devlogs",
	"maybe this might get into sage '26 if i finish it fast enough..",
	"Did you know? ducks can sleep with one eye open",
	"twin, lock in",
	"Remember to take breaks!",
	"Touch grass if this takin long"
]



var rng_message = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_generate_Message()
	anim.play("Intro_1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if LoadScreen.progress.size() > 0:
		$Progress_Display/Progress_Text.text = str(int(LoadScreen.progress[0] * 100)) + "%"
		$Progress_Display/Progress_Bar.value = LoadScreen.progress[0] * 100

func _on_message_generate_timer_timeout() -> void:
	_generate_Message()

func _generate_Message() -> void:
	rng_message.randomize()
	var message_index = rng_message.randi_range(0, message.size() - 1)
	if has_node("Chat/Message"):
		$Chat/Message.text = str(message[message_index])

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Intro_1":
		await get_tree().create_timer(3).timeout
		LoadScreen.load_scene("Scenes/Jobs/Job 1.tscn")
