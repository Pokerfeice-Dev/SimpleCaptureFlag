extends CharacterBody2D

@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"

func _physics_process(_delta: float) -> void:
	_handle_movement()

func _handle_movement() -> void:
	var direction := _get_input_direction()
	_update_velocity(direction)
	_update_visuals(direction)

func _get_input_direction() -> Vector2:
	var x := Input.get_action_strength("right") - Input.get_action_strength("left")
	var y := Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(x, y).normalized()

func _update_velocity(direction: Vector2) -> void:
	velocity = direction * speed
	move_and_slide()

func _update_visuals(direction: Vector2) -> void:
	if _is_idle(direction):
		_play_idle_animation()
		return
	
	_play_walk_animation(direction)

func _is_idle(direction: Vector2) -> bool:
	return direction == Vector2.ZERO

func _play_idle_animation() -> void:
	animated_sprite.play("Idle_" + last_direction)

func _play_walk_animation(direction: Vector2) -> void:
	last_direction = _get_direction_name(direction)
	animated_sprite.play("Walk_" + last_direction)

func _get_direction_name(direction: Vector2) -> String:
	if _is_horizontal(direction):
		return _get_horizontal_name(direction)
	return _get_vertical_name(direction)

func _is_horizontal(direction: Vector2) -> bool:
	return abs(direction.x) > abs(direction.y)

func _get_horizontal_name(direction: Vector2) -> String:
	return "right" if direction.x > 0 else "left"

func _get_vertical_name(direction: Vector2) -> String:
	return "down" if direction.y > 0 else "up"
