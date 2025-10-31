class_name MovePlayerFromInput
extends Node

@export var speed_move_params : WowStructs.STRUCT_WowServerMoveConfiguration
@export var claim_index_to_array_index : Array[WowStructs.STRUCT_ClaimIndexToArrayIndex] = []
@export var players_state_in_game : Array[WowStructs.STRUCT_WowPlayerState] = []
@export var players_input_in_game : Array[WowStructs.STRUCT_MoveInput] = []


func get_array_index_from_claim_index(claim_index:int)->int:
	for mapping in claim_index_to_array_index:
		if mapping.claim_index == claim_index:
			return mapping.array_index
	return -1

func get_player_input_by_claim_index(claim_index:int)->WowStructs.STRUCT_MoveInput:
	var array_index = get_array_index_from_claim_index(claim_index)
	return get_player_input(array_index)

func get_player_state_by_claim_index(claim_index:int)->WowStructs.STRUCT_WowPlayerState:
	var array_index = get_array_index_from_claim_index(claim_index)
	return get_player_state(array_index)

func set_player_state_by_claim_index(claim_index:int, state:WowStructs.STRUCT_WowPlayerState)->void:
	var array_index = get_array_index_from_claim_index(claim_index)
	players_state_in_game[array_index] = state

func set_player_input_by_claim_index(claim_index:int, input:WowStructs.STRUCT_MoveInput)->void:
	var array_index = get_array_index_from_claim_index(claim_index)
	players_input_in_game[array_index] = input
