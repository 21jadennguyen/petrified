class_name State
extends Node

@export var animation_name: String
@export var move_speed: float = 400
@export var wall_gravity: float = 100
@export var dash_speed: float = 2000
@export var flipped: bool = false

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var animations: AnimationPlayer
var move_component
var parent: CharacterBody2D

func enter() -> void:
	animations.play(animation_name)
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func get_movement_input() -> float:
	return move_component.get_movement_direction()

func get_jump() -> bool:
	return move_component.wants_jump()
