extends CanvasLayer


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
var can_load:bool = false
var target_scene_path: String = ""

func _ready() -> void:
	_generate_Message()
	if has_node("AnimationPlayer"):
		$AnimationPlayer.animation_finished.connect(_on_animation_player_animation_finished)

func _process(_delta: float) -> void:
	if can_load:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
		
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			# Show 100% briefly before switching
			if has_node("Progress_Display/Progress_Bar"):
				$Progress_Display/Progress_Bar.value = 100
			if has_node("Progress_Display/Progress_Text"):
				$Progress_Display/Progress_Text.text = "100%"
			
			# Small delay so user sees completion
			await get_tree().create_timer(0.3).timeout
			
			var scene = ResourceLoader.load_threaded_get(target_scene_path)
			get_tree().change_scene_to_packed(scene)
			
		elif status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var percent = progress[0] * 100
			if has_node("Progress_Display/Progress_Bar"):
				$Progress_Display/Progress_Bar.value = percent
			if has_node("Progress_Display/Progress_Text"):
				$Progress_Display/Progress_Text.text = str(int(percent)) + "%"
			
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			if has_node("Progress_Display/Progress_Text"):
				$Progress_Display/Progress_Text.text = "Error"

func _on_message_generate_timer_timeout() -> void:
	_generate_Message()

func _generate_Message() -> void:
	rng_message.randomize()
	var message_index = rng_message.randi_range(0, message.size() - 1)
	if has_node("Chat/Message"):
		$Chat/Message.text = message[message_index]

func load_scene(scene_path: String) -> void:
	target_scene_path = scene_path
	show()
	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("Job 1 - Intro")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	ResourceLoader.load_threaded_request(target_scene_path)
	can_load = true
