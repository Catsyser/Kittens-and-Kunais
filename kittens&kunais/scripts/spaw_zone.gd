extends Marker3D

# Telling the path to the target scene
@export var alvo_scene : PackedScene

# Lets define the spaw area size(X AIXS = width, Y AXIS = height)
@export var area_size : Vector2 = Vector2(8, 4)

# Timer's path
@onready var timer = $Timer

func _ready():
	pass

func _on_timer_timeout():
	spawn_target()

func spawn_target():
	# just in case...
	if alvo_scene == null:
		return
	
	# 1. Create a new target instance
	var new_target = alvo_scene.instantiate()
	
	# 2. Add it to the world (it should be a child of the world, not the spawner)
	get_tree().root.add_child(new_target)
	
	# 3. Calculate a random position
	# We go by the marker3D position as the center
	# Random pick a value between +-half of each axis
	
	var random_x = randf_range(-area_size.x / 2, area_size.x / 2)
	var random_y = randf_range(-area_size.y / 2, area_size.y / 2)
	
	# Combine with the spawner position
	var offset = Vector3(random_x, random_y, 0)
	
	# Apply it
	new_target.global_position = global_position + offset
	new_target.initial_y = new_target.global_position.y
