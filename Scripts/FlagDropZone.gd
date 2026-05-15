extends Area2D

func _on_body_entered(body: Node) -> void:
	_handle_flag_delivery(body)

func _handle_flag_delivery(body: Node) -> void:
	if not body.is_in_group("player"):
		return

	var flag = body.get_node_or_null("FlagHolder/Flag")
	if flag == null:
		return

	flag.queue_free()
	call_deferred("_progress_to_next_scene")

func _progress_to_next_scene() -> void:
	var target_path := _get_target_scene_path()
	if target_path == "":
		return
	
	_change_scene(target_path)

func _get_target_scene_path() -> String:
	var current_scene_name := get_tree().current_scene.name
	
	match current_scene_name:
		"main":
			return "res://Scenes/next_level.tscn"
		"main2":
			return "res://Scenes/win.tscn"
	
	return ""

func _change_scene(path: String) -> void:
	var scene := load(path) as PackedScene
	if scene:
		get_tree().change_scene_to_packed(scene)
