extends CharacterBody2D

@export var speed: float = 100.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_area: Area2D = $Detection_area
@onready var hit_area: Area2D = $Hit_area
@onready var sfx_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var target: Node2D = null
var last_direction: String = "down"

func _physics_process(_delta: float) -> void:
	_handle_movement()

func _handle_movement() -> void:
	if not is_instance_valid(target):
		_stop_movement()
		return
	
	_follow_target()

func _stop_movement() -> void:
	velocity = Vector2.ZERO
	_play_animation(Vector2.ZERO)

func _follow_target() -> void:
	var direction := (target.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	_play_animation(direction)

func _play_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		_play_idle()
		return
	
	_play_walk(direction)

func _play_idle() -> void:
	animated_sprite.play("Idle_" + last_direction)

func _play_walk(direction: Vector2) -> void:
	last_direction = _get_direction_name(direction)
	animated_sprite.play("Walk_" + last_direction)

func _get_direction_name(direction: Vector2) -> String:
	var x := direction.x
	var y := direction.y
	
	if abs(x) > abs(y):
		return "right" if x > 0 else "left"
	
	return "down" if y > 0 else "up"

func _on_detection_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		target = body

func _on_detection_body_exited(body: Node) -> void:
	if body == target:
		target = null

func _on_hit_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		call_deferred("_trigger_defeat")

func _trigger_defeat() -> void:
	Global.last_level_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://Scenes/defeat.tscn")

func _on_timer_timeout() -> void:
	sfx_player.play()
