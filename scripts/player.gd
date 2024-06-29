extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 700

@export var acc = 20
@export var dashspeed = 5000
@export var dashlength = .05

@export var wall_slide_speed = 100
@export var wall_slide_gravity = 100

var dashused : bool = false
var is_wall_sliding : bool = false

@onready var dash = $Dash

func _physics_process(delta):
	
	#gravity
	if !is_on_floor():	
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
			
	# one dash per jump
	if is_on_floor():
		dashused = false
	
	# jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force
		elif is_on_wall():
			if Input.is_action_pressed("move_left"):
				velocity.y = -jump_force
				velocity.x = 500
			if Input.is_action_pressed("move_right"):
				velocity.y = -jump_force
				velocity.x = -500
		
	# dash
	if Input.is_action_just_pressed("dash") and !dashused:
		dashused = true
		dash.start_dash(dashlength)
	var speed = dashspeed if dash.is_dashing() else speed
	
	# move left and right
	if Input.is_action_pressed("move_right"):
		if dash.is_dashing():
			velocity.x = speed
		else:
			velocity.x = min(velocity.x + acc, speed)
	elif Input.is_action_pressed("move_left"):
		if dash.is_dashing():
			velocity.x = -speed
		else:
			velocity.x = max(velocity.x - acc, -speed)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.05)
		
	if(is_on_wall() and !is_on_floor()):
		if Input.is_action_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			velocity.y += (wall_slide_gravity * delta)
			velocity.y = min(velocity.y, wall_slide_speed)
		
	# crouch
	if Input.is_action_pressed("crouch"):
		$CrouchingShape.disabled = false
		$NormalShape.disabled = true
		$Sprite2D.position.x = 0
		$Sprite2D.position.y = -35.5
		$Sprite2D.scale.y = 0.539
		speed = 200
		jump_force = 0
	else:
		$CrouchingShape.disabled = true
		$NormalShape.disabled = false
		$Sprite2D.position.x = 0
		$Sprite2D.position.y = -65
		$Sprite2D.scale.y = 1
		if !dash.is_dashing():
			speed = 300
		jump_force = 700
		
	
	move_and_slide()
