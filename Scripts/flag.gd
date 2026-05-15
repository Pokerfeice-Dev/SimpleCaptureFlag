extends Area2D

var is_taken: bool = false
var carrier: Node2D = null

func _on_body_entered(body: Node) -> void:
	_handle_collection(body)

func _handle_collection(body: Node) -> void:
	if is_taken:
		return

	if not body.is_in_group("player"):
		return
		
	_take_flag(body)

func _take_flag(body: Node2D) -> void:
	carrier = body
	is_taken = true
	call_deferred("_reparent_to_carrier")

func _reparent_to_carrier() -> void:
	if not carrier:
		return
		
	if not carrier.has_node("FlagHolder"):
		return
		
	var holder = carrier.get_node("FlagHolder")
	get_parent().remove_child(self)
	holder.add_child(self)
	global_position = holder.global_position
	position = Vector2.ZERO
	_disable_monitoring()

func _disable_monitoring() -> void:
	monitoring = false
	_disable_collision()

func _disable_collision() -> void:
	if has_node("CollisionShape2D"):
		var collision = $CollisionShape2D
		collision.set_deferred("disabled", true)
		collision.visible = false
