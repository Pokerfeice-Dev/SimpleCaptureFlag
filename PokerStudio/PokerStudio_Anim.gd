extends Node2D

# Llamado cuando el nodo es agregado al árbol por primera vez.
func _ready():
	# Crear un nuevo temporizador y agregarlo como un nodo hijo.
	var timer = Timer.new()
	add_child(timer)

	# Configurar el temporizador para que se dispare después de 5 segundos.
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
