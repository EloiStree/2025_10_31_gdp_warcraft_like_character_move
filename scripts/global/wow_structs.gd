
class_name WowStructs


enum ENUM_WowMountState {
	WALKING = 0,
	MOUNTED = 1,
	FLYING = 2,
	SKYDIVING = 3,
}

class STRUCT_WowPlayerState extends Resource:
	# Represent the state of a player in the world inside godot
	@export var player_claim_int_id := 0
	@export var player_local_network_id := 0
	@export var position_in_world := Vector3.ZERO
	@export var horizontal_rotation_in_map_360_ccw := 0.0
	@export var vertical_tilt_rotation_in_degree := 0.0
	@export var has_ground := true
	@export var is_in_water := false
	@export var mount_state := ENUM_WowMountState.WALKING


class STRUCT_WowPlayerLifeManaState extends Resource:
	@export var current_health := 100
	@export var current_mana := 100



class STRUCT_WowServerMoveConfiguration extends Resource:
	# Represent a configurable speed for each movement type
	@export var ground_move_forward:=7
	@export var ground_move_backward:=4
	@export var ground_move_left:=7
	@export var ground_move_right:=7
	@export var ground_strafe_left:=7
	@export var ground_strafe_right:=7
	@export var ground_rotate_left_degree:=180
	@export var ground_rotate_right_degree:=180


	@export var ground_mount_move_forward:=7
	@export var ground_mount_move_backward:=4
	@export var ground_mount_move_left:=7
	@export var ground_mount_move_right:=7
	@export var ground_mount_strafe_left:=7
	@export var ground_mount_strafe_right:=7
	@export var ground_mount_rotate_left_degree:=180
	@export var ground_mount_rotate_right_degree:=180


	@export var steady_fly_move_forward:=7
	@export var steady_fly_move_backward:=7
	@export var steady_fly_move_left:=7
	@export var steady_fly_move_right:=7
	@export var steady_fly_move_down:=7
	@export var steady_fly_move_up:=7
	@export var steady_fly_strafe_left:=7
	@export var steady_fly_strafe_right:=7
	@export var steady_fly_rotate_left_degree:=180
	@export var steady_fly_rotate_right_degree:=180
	@export var steady_fly_rotate_down_degree:=180
	@export var steady_fly_rotate_up_degree:=180

	@export var swimming_move_front:=7
	@export var swimming_move_backward:=7
	@export var swimming_move_left:=7
	@export var swimming_move_right:=7
	@export var swimming_move_down:=7
	@export var swimming_move_up:=7
	@export var swimming_strafe_left:=7
	@export var swimming_strafe_right:=7
	@export var swimming_rotate_left_degree:=180
	@export var swimming_rotate_right_degree:=180
	@export var swimming_rotate_down_degree:=180
	@export var swimming_rotate_up_degree:=180


class STRUCT_ChampionMoveInput extends Resource:
	@export var move_left: bool
	@export var move_right: bool
	@export var move_forward: bool
	@export var move_backward: bool
	@export var move_up: bool
	@export var move_down: bool
	@export var rotate_left: bool
	@export var rotate_right: bool
	@export var rotate_tilt_down: bool
	@export var rotate_tilt_up: bool


class STRUCT_ChampionInteractionInput extends Resource:
	@export var power0:bool
	@export var power1:bool
	@export var power2:bool
	@export var power3:bool
	@export var power4:bool
	@export var power5:bool
	@export var power6:bool
	@export var power7:bool
	@export var power8:bool
	@export var power9:bool

	@export var next_selection : bool
	@export var interact_with : bool

class STRUCT_ClaimIndexToArrayIndex extends Resource:
	@export var claim_index : int = -1
	@export var array_index : int = -1
