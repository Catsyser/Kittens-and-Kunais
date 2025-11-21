extends CharacterBody3D


#Kunai spawing
@export var kunai_scene : PackedScene

#Reference for all the obejcts used (making the names shorter)
@onready var camera_raycast = $"CameraRoot/CameraYaw/CameraPìtch/Camera3D/RayCast3D"
@onready var spawn_kunai = $CameraRoot/aimSpawKunai #this is a marker3D btw
@onready var score_label = $UI/ScoreLabel #score label
@onready var strike1 = $UI/strike1
@onready var strike2 = $UI/strike2
@onready var strike3 = $UI/strike3

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	score_label.text = "Score: " + str(Global.score)
	Global.score_changed.connect(_on_score_update)
	Global.strike_changed.connect(_on_strike_uptade)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "foward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Input.is_action_just_pressed("shoot"):
		shoot_kunai()

	move_and_slide()

func shoot_kunai():
	# it was just for debug
	if kunai_scene == null:
		print("error")
		return
	
	# Force RayCast to update its collision
	camera_raycast.force_raycast_update()
	# Determinate the destination point
	var target_point
	var distance_to_target = 1000.0
	#if the raycast find a target
	if camera_raycast.is_colliding():
		target_point = camera_raycast.get_collision_point()
		distance_to_target = camera_raycast.global_position.distance_to(target_point)
	else: #if it didnt find a target, use the last point of the raycast
		target_point = camera_raycast.to_global(camera_raycast.target_position)
		pass
		
	# Instance of a kunai
	var kunai = kunai_scene.instantiate()
	# Position and shoot kunai, also making it a child of main, not the player
	get_tree().root.add_child(kunai)
	#kunai.global_position = spawn_kunai.global_position #spaw_kunai refers to the marker3D
	if distance_to_target < 3.0:
		# Sai da posição da câmera (levemente à frente para não bater na cara do player)
		kunai.global_position = camera_raycast.global_position + (camera_raycast.global_transform.basis.z * -0.5)
	else:
		# Comportamento normal (Mão)
		kunai.global_position = spawn_kunai.global_position
	# This last line literally make the kunai, in its spaw point, look to the destiny
	kunai.look_at(target_point)
	
func _on_score_update(new_score):
	# Atualiza o texto na tela
	score_label.text = "Score: " + str(new_score)

func _on_strike_uptade(new_strike):
	if Global.strike == 1:
		strike1.visible = true
	elif Global.strike == 2:
		strike2.visible = true
	elif Global.strike == 3:
		strike3.visible = true
	else:
		pass
