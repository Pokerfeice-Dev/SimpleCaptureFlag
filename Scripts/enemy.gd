extends CharacterBody2D

@export var speed: float = 100.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = $Detection_area
@onready var hit_area: Area2D = $Hit_area
@onready var sfx_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var target: Node2D = null
var last_direction: String = "down"

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(target):
		velocity = Vector2.ZERO
		_play_animation(Vector2.ZERO)
		return

	var direction: Vector2 = (target.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	_play_animation(direction)

func _play_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		animated_sprite.play("Idle_" + last_direction)
		return

	last_direction = _get_direction_name(direction)
	animated_sprite.play("Walk_" + last_direction)

func _get_direction_name(direction: Vector2) -> String:
	var x: float = direction.x
	var y: float = direction.y
	var abs_x: float = abs(x)
	var abs_y: float = abs(y)

	if abs_x > abs_y:
		return "right" if x > 0 else "left"
	if abs_y > abs_x:
		return "down" if y > 0 else "up"
	return last_direction

func _on_detection_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		target = body

func _on_detection_body_exited(body: Node) -> void:
	if body == target:
		target = null

func _on_hit_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		call_deferred("_go_to_main_menu")

func _go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_timer_timeout() -> void:
	sfx_player.play()
