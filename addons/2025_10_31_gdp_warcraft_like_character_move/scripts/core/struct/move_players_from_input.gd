class_name MovePlayersFromInput
extends Node

@export var speed_move_params : WowStructs.STRUCT_WowServerMoveConfiguration
@export var claim_index_to_array_index : Array[WowStructs.STRUCT_ClaimIndexToArrayIndex] = []
@export var players_state_in_game : Array[WowStructs.STRUCT_WowPlayerState] = []
@export var players_input_in_game : Array[WowStructs.STRUCT_ChampionMoveInput] = []


func add_or_override_player(claim_index:int)->void:
	var array_index = get_array_index_from_claim_index(claim_index)
	if array_index == -1:
		var new_mapping = WowStructs.STRUCT_ClaimIndexToArrayIndex.new()
		new_mapping.claim_index = claim_index
		new_mapping.array_index = players_state_in_game.size()
		claim_index_to_array_index.append(new_mapping)
		
		var new_state = WowStructs.STRUCT_WowPlayerState.new()
		players_state_in_game.append(new_state)
		
		var new_input = WowStructs.STRUCT_ChampionMoveInput.new()
		players_input_in_game.append(new_input)


func get_array_index_from_claim_index(claim_index:int)->int:
	for mapping in claim_index_to_array_index:
		if mapping.claim_index == claim_index:
			return mapping.array_index
	return -1

func get_player_input(array_index:int)->WowStructs.STRUCT_ChampionMoveInput:
	return players_input_in_game[array_index]
func get_player_state(array_index:int)->WowStructs.STRUCT_WowPlayerState:
	return players_state_in_game[array_index]

func get_player_input_by_claim_index(claim_index:int)->WowStructs.STRUCT_ChampionMoveInput:
	var array_index = get_array_index_from_claim_index(claim_index)
	return get_player_input(array_index)

func get_player_state_by_claim_index(claim_index:int)->WowStructs.STRUCT_WowPlayerState:
	var array_index = get_array_index_from_claim_index(claim_index)
	return get_player_state(array_index)

func set_player_state_by_claim_index(claim_index:int, state:WowStructs.STRUCT_WowPlayerState)->void:
	var array_index = get_array_index_from_claim_index(claim_index)
	players_state_in_game[array_index] = state

func set_player_input_by_claim_index(claim_index:int, input:WowStructs.STRUCT_ChampionMoveInput)->void:
	var array_index = get_array_index_from_claim_index(claim_index)
	players_input_in_game[array_index] = input
