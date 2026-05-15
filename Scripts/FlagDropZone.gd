extends Area2D 

@export var win_scene: PackedScene

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return

	var flag = body.get_node_or_null("FlagHolder/Flag")
	if flag == null:
		print_debug("No podés ganar sin la bandera.")
		return

	flag.queue_free()
	call_deferred("change_to_win_scene")

func change_to_win_scene() -> void:
	get_tree().change_scene_to_packed(win_scene)
