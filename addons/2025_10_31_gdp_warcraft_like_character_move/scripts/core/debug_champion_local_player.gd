extends Node
class_name DebugChampionLocalPlayer

@export var pool_to_affect : MovePlayersFromInput
@export var claim_index:int = 42
@export var input_move_left:= "Q"
@export var input_move_right:= "E"
@export var input_move_up:= "R"
@export var input_move_down:= "F"
@export var input_move_forward:= "W"
@export var input_move_backward:= "S"
@export var input_rotate_left:= "A"
@export var input_rotate_right:= "D"
@export var input_rotate_up:= "T"
@export var input_rotate_down:= "G"
@export var input_reset_start_position:= "Y"
@export var input_reset_random_position:= "H"
@export var move_direction:Vector3
@export var rotate_direction:Vector2

func _input(event):
	if event is InputEventKey:
		print("Key pressed: %s" % event.as_text())
		if event.as_text() == input_reset_start_position and event.pressed:
			pool_to_affect.reset_player_position_by_claim_index(claim_index)
			return  
		if event.as_text() == input_reset_random_position and event.pressed:
			pool_to_affect.reset_player_at_random_position_by_claim_index(claim_index, 64.0, 32.0)
			
			
			return 
			
		var player_input :WowStructs.STRUCT_ChampionMoveInput= pool_to_affect.get_or_create_player_input_by_claim_index(claim_index)
		if event.as_text() == input_move_left:
			player_input.move_left = event.is_pressed()
		elif event.as_text() == input_move_right:
			player_input.move_right = event.is_pressed()
		elif event.as_text() == input_move_forward:
			player_input.move_forward = event.is_pressed()
		elif event.as_text() == input_move_backward:
			player_input.move_backward = event.is_pressed()
		elif event.as_text() == input_move_up:
			player_input.move_up = event.is_pressed()
		elif event.as_text() == input_move_down:
			player_input.move_down = event.is_pressed()
		elif event.as_text() == input_rotate_left:
			player_input.rotate_left = event.is_pressed()
		elif event.as_text() == input_rotate_right:
			player_input.rotate_right = event.is_pressed()
		elif event.as_text() == input_rotate_up:
			player_input.rotate_tilt_up = event.is_pressed()
		elif event.as_text() == input_rotate_down:
			player_input.rotate_tilt_down = event.is_pressed()
