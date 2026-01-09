extends Node2D

#elements used for events
var icicle = preload("res://Scenes/Jobs/Subscenes/Icicle.tscn")
var beam = preload("res://Scenes/Jobs/Subscenes/Beam.tscn")
var thunder = preload("res://Scenes/Jobs/Subscenes/Thunder.tscn")
var blue_balloon = preload("res://Scenes/Jobs/Subscenes/Blue_balloon.tscn")
var yellow_balloon = preload("res://Scenes/Jobs/Subscenes/Yellow_balloon.tscn")
var green_balloon = preload("res://Scenes/Jobs/Subscenes/Green_balloon.tscn")
var red_balloon = preload("res://Scenes/Jobs/Subscenes/Red_balloon.tscn")


#this event list is gonna used to like select different events and stuff like if its thunder then we will spawn thunder and if its sunshine we will spawn sunshine and same for others.
var events = [
	"Thunder Incoming!",
	"Hotass Sunshine",
	"Freezing Winds",
	"Neutral"
]
var event_active:bool = false

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Intro")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	$CanvasLayer/Score.text = "Score: %d" % get_node("Player").score
	$CanvasLayer/HP_display.text = "HP: %d" % get_node("Player").HP

func _event():

	event_active = false
	#picks events
	rng.randomize()
	var event_index = rng.randi_range(0, 3) # Adjusted to 3 to exclude "Neutral" from random selection
	var selected_event = events[event_index]
	print(event_index)
	$"CanvasLayer/Wheater Alert/Event".text = selected_event

	#shows event selected in console for debugging
	print("Event Selected: %s" % selected_event)

	# Play alert sound
	$SFX/alert.play()
	
	# Display alert to the player with slide-in animation
	$"CanvasLayer/Wheater Alert".position = Vector2(0, -127)  # Start off-screen
	$"CanvasLayer/Wheater Alert".show()
	
	var tween = create_tween()
	tween.tween_property($"CanvasLayer/Wheater Alert", "position", Vector2(0, 1), 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await tween.finished
	
	# Wait for 3 seconds
	await get_tree().create_timer(3.0).timeout
	
	# Slide out animation
	var tween2 = create_tween()
	tween2.tween_property($"CanvasLayer/Wheater Alert", "position", Vector2(0, -127), 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tween2.finished
	$"CanvasLayer/Wheater Alert".hide()

	# Here you can add code to trigger the actual event effects in the game.
	if selected_event == "Neutral":
		print("No significant weather event.")
		var tween3 = create_tween()
		tween3.tween_property($CanvasModulate, "color", Color(1.0, 1.0, 1.0, 1.0), 2.0)
		await tween3.finished
		return
		
	if selected_event == "Thunder Incoming!":
		event_active = true
		_thunder_event()
	
	if selected_event == "Hotass Sunshine":
		event_active = true
		_sunshine()

	if selected_event == "Freezing Winds":
		event_active = true
		_freezing_winds()

func _thunder_event():
		var tween = create_tween()
		tween.tween_property($CanvasModulate, "color", Color(0.24, 0.27, 0.33, 1.0), 2.0)
		await tween.finished
		print("Spawning thunder effects...")
		# Add thunder effect code here

		while event_active:
			_thunder_bolt(Vector2.ZERO)
			_thunder_bolt(Vector2.ZERO)
			_thunder_bolt(Vector2.ZERO)
			await get_tree().create_timer(4).timeout
		return

func _sunshine():
	var tween = create_tween()
	tween.tween_property($CanvasModulate, "color", Color(1.0, 0.78, 0.48, 1.0), 2.0)
	await tween.finished
	print("Spawning sunshine effects...")
		# Add sunshine effect code here
	
	while event_active:
		_sun_beam(Vector2.ZERO)
		_sun_beam(Vector2.ZERO)
		_sun_beam(Vector2.ZERO)
		await get_tree().create_timer(3).timeout
	return

func _freezing_winds():
	var tween = create_tween()
	tween.tween_property($CanvasModulate, "color", Color(0.15, 0.55, 0.57, 1.0), 2.0)
	await tween.finished

	print("Spawning freezing stuff...")
	while event_active:
		_freeze(Vector2.ZERO)
		await get_tree().create_timer(0.2).timeout
	return

func _sun_beam(pos):
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		var beam_instance = beam.instantiate()
		add_child(beam_instance)
		beam_instance.position = Vector2(rng.randi_range(-186, 186), -98)

func _freeze(pos):
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		var icicle_instance = icicle.instantiate()
		add_child(icicle_instance)
		icicle_instance.position = Vector2(rng.randi_range(-186, 186), -92)

func _thunder_bolt(pos):
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		var thunder_instance = thunder.instantiate()
		add_child(thunder_instance)
		thunder_instance.position = Vector2(rng.randi_range(-186, 186), -98)

func _on_event_cooldown_timeout() -> void:
	_event()
	$Timer/event_cooldown.stop()
	print("Event Incoming!")


func _on_blue_balloon_spawn_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var blue_balloon_instance = blue_balloon.instantiate()
	add_child(blue_balloon_instance)
	blue_balloon_instance.position = Vector2(rng.randi_range(-186, 186), 109)

func _on_yellow_balloon_spawn_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var yellow_balloon_instance = yellow_balloon.instantiate()
	add_child(yellow_balloon_instance)
	yellow_balloon_instance.position = Vector2(rng.randi_range(-186, 186), 109)

func _on_green_balloon_spawn_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var green_balloon_instance = green_balloon.instantiate()
	add_child(green_balloon_instance)
	green_balloon_instance.position = Vector2(rng.randi_range(-186, 186), 109)


func _on_red_balloon_spawn_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var red_balloon_instance = red_balloon.instantiate()
	add_child(red_balloon_instance)
	red_balloon_instance.position = Vector2(rng.randi_range(-186, 186), 109)


func _on_player__death() -> void:
	event_active = false
	print("Player has died, stopping events.")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Intro":
		$Timer/event_cooldown.start()
		$Timer/blue_balloon_spawn.start()
		$Timer/yellow_balloon_spawn.start()
		$Timer/green_balloon_spawn.start()
		$Timer/red_balloon_spawn.start()
		$"CanvasLayer/Wheater Alert".hide()
