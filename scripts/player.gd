extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25

@export_group("Mouvement")
@export var SPEED = 8.0
@export var JUMP_VELOCITY = 12.0
@export var ACCELERATION = 20.0
@export var ROTATION_SPEED = 12.0

var _last_mouvement_dir := Vector3.BACK
var _camera_input_direction := Vector2.ZERO
var _gravity := -30.0

var was_on_floor := true
var is_jumping := false
var is_landing := false
var in_air := false
var should_stun := false
var y_at_start_falling := 0.0

@onready var _camera: Camera3D = $%Camera3D
@onready var _skin = %John
@onready var _camera_pivot: Node3D = %CameraPivot

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("show_mouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_camera_input_direction = event.screen_relative * mouse_sensitivity


func _physics_process(delta: float) -> void:
	
	var max_up_angle := deg_to_rad(85)
	var max_down_angle := deg_to_rad(-85)

	_camera_pivot.rotation.x += (_camera_input_direction.y * delta) * -1
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, max_down_angle, max_up_angle)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	_camera_input_direction = Vector2.ZERO

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var direction := forward * input_dir.y + right * input_dir.x
	direction.y = 0.0
	direction = direction.normalized()

	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	velocity.y = y_velocity + _gravity * delta

	# --- SAUT ---
	var starting_jump := Input.is_action_just_pressed("jump") and is_on_floor() and not should_stun
	if starting_jump:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		was_on_floor = false
		_skin.jumpstart()

	if not should_stun:
		move_and_slide()

	if direction.length() > 0.2:
		_last_mouvement_dir = direction
	var target_angle = Vector3.BACK.signed_angle_to(_last_mouvement_dir, Vector3.UP)
	if not should_stun:
		_skin.global_rotation.y = lerp_angle(_skin.global_rotation.y, target_angle, ROTATION_SPEED * delta)

	if not is_on_floor() and velocity.y <= 0:
		if not in_air:
			y_at_start_falling = position.y
		in_air = true
		is_jumping = false
		_skin.fall()

	if is_on_floor() and in_air:
		in_air = false
		is_landing = true
		if y_at_start_falling - position.y >= 4 and is_landing:
			should_stun = true
		_skin.jumpend("Idle" if direction.length() < 0.2 else "Sprint")


	was_on_floor = is_on_floor()

	if not is_jumping and not is_landing and is_on_floor():
		should_stun = false
		if direction.length() > 0.2:
			_skin.sprint()
		else:
			_skin.idle()
