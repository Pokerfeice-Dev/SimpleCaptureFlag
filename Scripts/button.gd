extends Control

func _on_pressed() -> void:
	_change_scene_to_file("res://Scenes/main.tscn")

func _on_options_pressed() -> void:
	_change_scene_to_file("res://Scenes/options.tscn")

func _on_back_pressed() -> void:
	_change_scene_to_file("res://Scenes/menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_menu_pressed() -> void:
	_change_scene_to_file("res://Scenes/menu.tscn")

func _on_credits_pressed() -> void:
	_change_scene_to_file("res://Scenes/credits.tscn")

func _on_pressed_next_level() -> void:
	_change_scene_to_file("res://Scenes/main_2.tscn")

func _on_reset_pressed() -> void:
	_handle_reset()

func _handle_reset() -> void:
	if Global.last_level_path == "":
		return

	var scene := load(Global.last_level_path) as PackedScene
	if scene:
		get_tree().change_scene_to_packed(scene)

func _change_scene_to_file(path: String) -> void:
	get_tree().change_scene_to_file(path)
