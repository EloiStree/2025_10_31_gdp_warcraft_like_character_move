extends Node	
class_name MovePlayersFromInput

#const WowStructs = preload("res://addons/2025_10_31_gdp_warcraft_like_character_move/scripts/global/wow_structs.gd")

@export var speed_move_params : WowStructs.STRUCT_WowServerMoveConfiguration
@export var claim_index_to_array_index : Array[WowStructs.STRUCT_ClaimIndexToArrayIndex] = []
@export var players_state_in_game : Array[WowStructs.STRUCT_WowPlayerState] = []
@export var players_input_in_game : Array[WowStructs.STRUCT_ChampionMoveInput] = []
@export var players_life_mana_in_game : Array[WowStructs.STRUCT_WowPlayerLifeManaState] = []
@export var players_debug_nodes_in_game : Array[Node3D] = []
@export var default_reset_start_point : Node3D

signal on_new_player_append(player_claim_index:int, player_array_index:int)


func _ready()->void:
	speed_move_params = WowStructs.STRUCT_WowServerMoveConfiguration.new()

func get_or_create_player_input_by_claim_index(claim_index:int)->WowStructs.STRUCT_ChampionMoveInput:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	return players_input_in_game[array_index]

func append_player_space(claim_index:int)->int:
	var new_mapping = WowStructs.STRUCT_ClaimIndexToArrayIndex.new()
	new_mapping.claim_index = claim_index
	new_mapping.array_index = players_state_in_game.size()
	claim_index_to_array_index.append(new_mapping)
	var new_state = WowStructs.STRUCT_WowPlayerState.new()
	players_state_in_game.append(new_state)
	var new_input = WowStructs.STRUCT_ChampionMoveInput.new()
	players_input_in_game.append(new_input)
	var new_life_mana = WowStructs.STRUCT_WowPlayerLifeManaState.new()
	players_life_mana_in_game.append(new_life_mana)
	on_new_player_append.emit(claim_index, new_mapping.array_index)
	return new_mapping.array_index



func get_array_index_from_claim_index(claim_index:int)->int:
	for mapping in claim_index_to_array_index:
		if mapping.claim_index == claim_index:
			return mapping.array_index
	return -1
func get_or_create_array_index_from_claim_index(claim_index:int)->int:
	var index = get_array_index_from_claim_index(claim_index)
	if index != -1:
		return index
	var new_index = append_player_space(claim_index)
	return new_index
	
func get_player_input(array_index:int)->WowStructs.STRUCT_ChampionMoveInput:
	return players_input_in_game[array_index]
func get_player_state(array_index:int)->WowStructs.STRUCT_WowPlayerState:
	return players_state_in_game[array_index]

func get_player_input_by_claim_index(claim_index:int)->WowStructs.STRUCT_ChampionMoveInput:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	return get_player_input(array_index)

func get_player_state_by_claim_index(claim_index:int)->WowStructs.STRUCT_WowPlayerState:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	return get_player_state(array_index)

func set_player_state_by_claim_index(claim_index:int, state:WowStructs.STRUCT_WowPlayerState)->void:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	players_state_in_game[array_index] = state

func set_player_input_by_claim_index(claim_index:int, input:WowStructs.STRUCT_ChampionMoveInput)->void:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	players_input_in_game[array_index] = input

func get_player_count()->int:
	return players_state_in_game.size()

func get_player_claim_index_list()->Array[int]:
	var claim_indexes : Array[int] = []
	for mapping in claim_index_to_array_index:
		claim_indexes.append(mapping.claim_index)
	return claim_indexes

func get_player_life_mana_state(claim_index:int)->WowStructs.STRUCT_WowPlayerLifeManaState:
	var array_index = get_array_index_from_claim_index(claim_index)
	return players_life_mana_in_game[array_index]

func get_player_life_mana_state_by_array_index(array_index:int)->WowStructs.STRUCT_WowPlayerLifeManaState:
	return players_life_mana_in_game[array_index]

func reset_player_position_by_claim_index(claim_index:int)->void:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	var state = players_state_in_game[array_index]
	if default_reset_start_point != null:
		state.position_in_world = default_reset_start_point.global_transform.origin
		
		# have to check when I am not sleeping on keyboard
		state.horizontal_rotation_in_map_360_ccw = default_reset_start_point.rotation_degrees.y
		state.vertical_tilt_rotation_in_degree = default_reset_start_point.rotation_degrees.x
		players_state_in_game[array_index] = state

func reset_player_at_random_position_by_claim_index(claim_index:int, range_xz:float=50.0, range_y:float=40.0)->void:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	var state = players_state_in_game[array_index]
	var random_pos = Vector3(
		randf_range(-range_xz, range_xz),
		randf_range(0, range_y),
		randf_range(-range_xz, range_xz)
	)
	state.position_in_world = random_pos
	players_state_in_game[array_index] = state

func reset_player_tilt_rotation_by_claim_index(claim_index:int)->void:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	var state = players_state_in_game[array_index]
	state.vertical_tilt_rotation_in_degree = 0.0
	players_state_in_game[array_index] = state


func teleport_player_to_position_by_claim_index(claim_index:int, position:Vector3)->void:
	var array_index = get_or_create_array_index_from_claim_index(claim_index)
	var state = players_state_in_game[array_index]
	state.position_in_world = position
	players_state_in_game[array_index] = state


func _process(delta:float)->void:
	for i in range(get_player_count()):
		var state = players_state_in_game[i]
		var input = players_input_in_game[i]
		if input.rotate_left:
			state.horizontal_rotation_in_map_360_ccw += speed_move_params.steady_fly_rotate_left_degree * delta
		if input.rotate_right:
			state.horizontal_rotation_in_map_360_ccw -= speed_move_params.steady_fly_rotate_right_degree * delta
		if input.rotate_tilt_up:
			state.vertical_tilt_rotation_in_degree += speed_move_params.steady_fly_rotate_up_degree * delta
		if input.rotate_tilt_down:
			state.vertical_tilt_rotation_in_degree -= speed_move_params.steady_fly_rotate_down_degree * delta
		
		var forward := Vector3(0, 0, -1)
		# rotate the forward on vertical axis with ccw rotation
		forward = forward.rotated(Vector3.UP, deg_to_rad(state.horizontal_rotation_in_map_360_ccw))
		# rotate the new forward down or up from it right axis
		var right := forward.cross(Vector3.UP).normalized()
		forward = forward.rotated(right, deg_to_rad(state.vertical_tilt_rotation_in_degree))

		var player_forward := forward.normalized()
		var player_right := player_forward.cross(Vector3.UP).normalized()
		var player_up := player_right.cross(player_forward).normalized()

		if input.move_forward:
			state.position_in_world += player_forward * speed_move_params.steady_fly_move_forward * delta
		if input.move_backward:
			state.position_in_world -= player_forward * speed_move_params.steady_fly_move_backward * delta
		if input.move_left:
			state.position_in_world -= player_right * speed_move_params.steady_fly_move_left * delta
		if input.move_right:
			state.position_in_world += player_right * speed_move_params.steady_fly_move_right * delta

		if input.move_up:
			state.position_in_world += player_up * speed_move_params.steady_fly_move_up * delta
		if input.move_down:
			state.position_in_world -= player_up * speed_move_params.steady_fly_move_down * delta

		players_state_in_game[i] = state

		if i < players_debug_nodes_in_game.size():
			var debug_node = players_debug_nodes_in_game[i]
			if debug_node != null:
				debug_node.global_transform.origin = state.position_in_world
				debug_node.rotation_degrees = Vector3(state.vertical_tilt_rotation_in_degree, state.horizontal_rotation_in_map_360_ccw, 0)
