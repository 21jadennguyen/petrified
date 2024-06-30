extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var dash_state: State

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.velocity.x = 5000
	parent.move_and_slide()
		
	return null
