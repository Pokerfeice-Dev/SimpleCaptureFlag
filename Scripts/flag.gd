extends Area2D

var is_taken: bool = false
var carrier: Node2D = null

func _ready():
	pass

func _on_body_entered(body: Node) -> void:
	if is_taken:
		return

	if body.is_in_group("player"):
		carrier = body
		is_taken = true
		call_deferred("reparent_to_carrier")

func reparent_to_carrier():
	if carrier and carrier.has_node("FlagHolder"):
		get_parent().remove_child(self)
		carrier.get_node("FlagHolder").add_child(self)
		global_position = carrier.get_node("FlagHolder").global_position
		position = Vector2.ZERO
		call_deferred("_disable_monitoring")

func _disable_monitoring():
	monitoring = false
	if has_node("CollisionShape2D"):
		$CollisionShape2D.set_deferred("disabled", true)
		$CollisionShape2D.visible = false
