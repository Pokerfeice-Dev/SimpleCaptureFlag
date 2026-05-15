extends CharacterBody2D

@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"

func _physics_process(_delta: float) -> void:
	var input_direction := get_input_direction()
	update_velocity(input_direction)
	play_animation(input_direction)

func get_input_direction() -> Vector2:
	var x := Input.get_action_strength("right") - Input.get_action_strength("left")
	var y := Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(x, y).normalized()

func update_velocity(direction: Vector2) -> void:
	velocity = direction * speed
	move_and_slide()

func play_animation(direction: Vector2) -> void:
	if is_idle(direction):
		play_idle_animation()
		return
	update_last_direction(direction)
	play_walk_animation()

func is_idle(direction: Vector2) -> bool:
	return direction == Vector2.ZERO

func play_idle_animation() -> void:
	var anim_name := "Idle_" + last_direction
	animated_sprite.play(anim_name)

func play_walk_animation() -> void:
	var anim_name := "Walk_" + last_direction
	animated_sprite.play(anim_name)

func update_last_direction(direction: Vector2) -> void:
	last_direction = get_direction_name(direction)

func get_direction_name(direction: Vector2) -> String:
	if is_horizontal(direction):
		return get_horizontal_direction(direction)
	return get_vertical_direction(direction)

func is_horizontal(direction: Vector2) -> bool:
	return abs(direction.x) > abs(direction.y)

func get_horizontal_direction(direction: Vector2) -> String:
	if direction.x > 0:
		return "right"
	return "left"

func get_vertical_direction(direction: Vector2) -> String:
	if direction.y > 0:
		return "down"
	return "up"
