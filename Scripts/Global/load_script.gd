extends CanvasLayer

var progress = []
var target_scene_path: String = ""
var scene_load_status = 0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if target_scene_path == "":
		return
	scene_load_status = ResourceLoader.load_threaded_get_status(target_scene_path,progress)
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var packed_scene = ResourceLoader.load_threaded_get(target_scene_path)
		if packed_scene is PackedScene:
			get_tree().change_scene_to_packed(packed_scene)
		else:
			push_error("Failed to load scene: " + target_scene_path)


func load_scene(scene_path: String) -> void:
	target_scene_path = scene_path
	ResourceLoader.load_threaded_request(target_scene_path)
