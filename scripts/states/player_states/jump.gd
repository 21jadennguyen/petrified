extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State
@export var wall_slide_state: State

@export var jump_force: float = 900.0

func enter() -> void:
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return fall_state
	
	var movement = get_movement_input() * move_speed
	
	if movement != 0:
		#animations.flip_h = movement < 0
		pass
	
	# For flipping sprite while changing directions (bugged)
	#if movement < 0:
		#move_component.direction = -1
		#print(flipped)
		#if !flipped:
			#parent.scale.x = -.2
			#flipped = true
	#elif movement > 0:
		#move_component.direction = 1
		#if flipped:
			#parent.scale.x = -.2
			#flipped = false
	
	parent.velocity.x = movement
	parent.move_and_slide()
	
	#if parent.is_on_wall_only():
		#return wall_slide_state
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	
	return null
