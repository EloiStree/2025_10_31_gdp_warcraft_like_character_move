


enum WOW_MOUNT_STATE {
	WALKING = 0,
	MOUNTED = 1,
	FLYING = 2,
	SKYDIVING = 3,
}

class STRUCT_WowPlayerState:
	@export var position_in_world:=Vector3.ZERO
	@export var horizontal_rotation_in_map_360_ccw:=0
	@export var vertical_tilt_rotation_in_degree:=0
	@export var has_ground:=true
	@export var is_in_water:=false
	@export var mount_state:=WOW_MOUNT_STATE.WALKING
	
	# func move_local_direction(direction:Vector3)->void:
	# 	var basis:=Basis()
	# 	basis = basis.rotated(Vector3.UP, deg2rad(-horizontal_rotation_in_map_360_ccw))
	# 	var global_direction:=basis.xform(direction).normalized()
	# 	position_in_world += global_direction * distance


class STRUCT_WowServerMoveConfiguration:
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
	
	
