extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 700

@export var acc = 20
@export var dashspeed = 5000
@export var dashlength = .05

var dashused = false
@onready var dash = $Dash

func _physics_process(delta):
	if !is_on_floor():	
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
			
	if is_on_floor():
		dashused = false
			
	if Input.is_action_just_pressed("dash") && !dashused:
		dashused = true
		dash.start_dash(dashlength)
	var speed = dashspeed if dash.is_dashing() else speed
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
			velocity.y = -jump_force
	
	if Input.is_action_pressed("move_right"):
		print(velocity.x)
		velocity.x = min(velocity.x + acc, speed)
	elif Input.is_action_pressed("move_left"):
		print(velocity.x)
		velocity.x = max(velocity.x - acc, -speed)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.05)
	
	move_and_slide()
