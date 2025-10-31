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
            
        elif event.as_text() == input_reset_random_position and event.pressed:
            var random_pos = Vector3(
                randf_range(-50, 50),
                randf_range(10, 50),
                randf_range(-50, 50)
            )
            var player_state :WowStructs.STRUCT_WowPlayerState= pool_to_affect.get_or_create_player_state_by_claim_index(claim_index)
            player_state.position_in_world = random_pos
            pool_to_affect.set_player_state_by_claim_index(claim_index, player_state)
            return

		var player_input :WowStructs.STRUCT_ChampionMoveInput= pool_to_affect.get_or_create_player_input_by_claim_index(claim_index)
		var input_vector := Vector3.ZERO
		var input_rotation:Vector2 = Vector2.ZERO
		
		if event.as_text() == input_move_left:
			input_vector.x = -1.0 if event.pressed else 0.0
		elif event.as_text() == input_move_right:
			input_vector.x = 1.0 if event.pressed else 0.0
		elif event.as_text() == input_move_forward:
			input_vector.z = -1.0 if event.pressed else 0.0
		elif event.as_text() == input_move_backward:
			input_vector.z = 1.0 if event.pressed else 0.0
		elif event.as_text() == input_move_up:
			input_vector.y = 1.0 if event.pressed else 0.0
		elif event.as_text() == input_move_down:
			input_vector.y = -1.0 if event.pressed else 0.0
		elif event.as_text() == input_rotate_left:
			input_rotation.x = -1.0 if event.pressed else 0.0
		elif event.as_text() == input_rotate_right:
			input_rotation.x = 1.0 if event.pressed else 0.0
		elif event.as_text() == input_rotate_down:
			input_rotation.y = -1.0 if event.pressed else 0.0
		elif event.as_text() == input_rotate_up:
			input_rotation.y = 1.0 if event.pressed else 0.0

		move_direction = input_vector
		rotate_direction = input_rotation
		update_with_vectors_direction(player_input, input_vector, input_rotation)

func update_with_vectors_direction(player_input:WowStructs.STRUCT_ChampionMoveInput, move_dir:Vector3, rotate_dir:Vector2)->void:
	player_input.move_left = move_dir.x < 0.0
	player_input.move_right = move_dir.x > 0.0
	player_input.move_forward = move_dir.z < 0.0
	player_input.move_backward = move_dir.z > 0.0
	player_input.move_up = move_dir.y > 0.0
	player_input.move_down = move_dir.y < 0.0
	player_input.rotate_left = rotate_dir.x < 0.0
	player_input.rotate_right = rotate_dir.x > 0.0
	player_input.rotate_tilt_down = rotate_dir.y < 0.0
	player_input.rotate_tilt_up = rotate_dir.y > 0.0
	pool_to_affect.set_player_input_by_claim_index(claim_index, player_input)
