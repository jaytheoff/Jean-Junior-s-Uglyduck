extends Node2D

#elements used for events
var icicle = preload("res://Scenes/Jobs/Subscenes/Icicle.tscn")

#this event list is gonna used to like select different events and stuff like if its thunder then we will spawn thunder and if its sunshine we will spawn sunshine and same for others.
var events = [
	"Thunder Incoming!",
	"Hotass Sunshine",
	"Freezing Winds",
	'Tornado Shenanigans',
	"Neutral"
]


var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"CanvasLayer/Wheater Alert".hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _event():

	#picks events
	rng.randomize()
	var event_index = rng.randi_range(0, 4)
	var selected_event = events[event_index]

	#shows event selected in console for debugging
	print("Event Selected: %s" % selected_event)

	# Display alert to the player
	$"CanvasLayer/Wheater Alert".show()
	await get_tree().create_timer(3.0).timeout
	$"CanvasLayer/Wheater Alert".hide()
	# Here you can add code to trigger the actual event effects in the game.

	if selected_event == "Thunder Incoming!":
		_thunder_event()
	
	if selected_event == "Hotass Sunshine":
		_sunshine()

	if selected_event == "Freezing Winds":
		_freezing_winds()

func _thunder_event():
		print("Spawning thunder effects...")
		# Add thunder effect code here

func _sunshine():
		print("Spawning sunshine effects...")
		# Add sunshine effect code here

func _freezing_winds():
	while events[2]:
		_freeze(Vector2.ZERO)
		await get_tree().create_timer(0.4).timeout

func _freeze(pos):
		print("Spawning freezing stuff...")

		var rng = RandomNumberGenerator.new()
		rng.randomize()

		var icicle_instance = icicle.instantiate()
		add_child(icicle_instance)
		icicle_instance.position = Vector2(rng.randi_range(-186, 186), -92)
		


func _on_event_cooldown_timeout() -> void:
	_event()
	print("Event Incoming!")
