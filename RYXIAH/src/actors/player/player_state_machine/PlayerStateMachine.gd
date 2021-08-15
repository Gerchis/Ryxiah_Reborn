extends Node

class_name PlayerStateMachine

var states: Dictionary = {}
var current_state: PlayerState

func _ready():
	yield (get_parent(), "ready")
	
	for state in get_children():
		states[state.name] = state
	for state in get_children():
		state.states = self.states
		state.player = get_parent()
	
	current_state = states["Idle"]
	enter()

func enter():
	current_state.enter()

func change_state(nextState):
	current_state = nextState
	enter()

func _physics_process(delta):
	current_state.physics_logic(delta)
	if current_state.get_transition() != null:
		change_state(current_state.get_transition())
