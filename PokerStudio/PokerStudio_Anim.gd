extends Node2D

func _ready() -> void:
	_setup_timer()

func _setup_timer() -> void:
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
