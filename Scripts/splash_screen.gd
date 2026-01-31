extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Engine Details Hidden
	$Engine/Powered.hide()
	$"Engine/Engine Name".hide()
	
	#Credits Hidden
	$"Credit/Dev Name".hide()
	$Credit/Presents.hide()
	
	#Show Engine Details
	await get_tree().create_timer(1.0).timeout
	$Engine.show()
	$Engine/Powered.show()
	await get_tree().create_timer(1.0).timeout
	$"Engine/Engine Name".show()
	
	await get_tree().create_timer(2.0).timeout
	$Engine.hide()
	
	#Show Credits
	await get_tree().create_timer(1.0).timeout
	$"Credit/Dev Name".show()
	await get_tree().create_timer(1.0).timeout
	$Credit/Presents.show()
	await get_tree().create_timer(1.0).timeout
	$Credit.hide()

	await get_tree().create_timer(1.0).timeout

	#switch to intro scene
	get_tree().change_scene_to_file("Scenes/Title Screen.tscn")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
