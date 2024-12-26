extends CharacterBody2D

var speed = 60
var jump_duration = 0.3
var jump_height = 15
var vel = Vector2.ZERO
var is_jumping = false
var jump_timer = 0.0
var initial_position = Vector2.ZERO

@onready var camera = $Camera2D
@onready var player = $AnimatedSprite2D

func _process(delta: float) -> void:
	camera.position = player.position

func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var is_moving = false

	if Input.is_action_pressed("go_right"):
		velocity.x += 1
		player.play("right")
		is_moving = true
	elif Input.is_action_pressed("go_left"):
		velocity.x -= 1
		player.play("left")
		is_moving = true

	if Input.is_action_pressed("go_up"):
		velocity.y -= 1
		player.play("up")
		is_moving = true
	elif Input.is_action_pressed("go_down"):
		velocity.y += 1
		player.play("down")
		is_moving = true

	if not is_moving:
		player.stop()

	vel = velocity.normalized() * speed
	position += vel * delta

	if is_jumping:
		jump_timer -= delta
		if jump_timer > 0:
			position.y = initial_position.y - jump_height * sin(jump_timer / jump_duration * PI)
		else:
			is_jumping = false
			position.y = initial_position.y

	elif Input.is_action_just_pressed("jump") and not is_jumping:
		is_jumping = true
		jump_timer = jump_duration
		initial_position = position
