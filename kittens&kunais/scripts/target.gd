extends Area3D

#--------------QUICK PHYSICS LESSON!--------------#
# We want to make a sine movement, so there are   #
# a couple properties that are worth remember:    #
# Amplitude means how high the oscilation happens #
# Frequency means how fast the oscilation happens #
#-------------------------------------------------#

# --- Putting these in the inspector to easily adjust --- #
@export_group("Movement")
@export var move_speed : float = 5.0      # Velocity FOWARD
@export var amplitude : float = 1.0       # oscilation's height
@export var frequency : float = 2.0       # oscilation's velocity

# Other stuff >:) im gonna explain this later..
var time_passed : float = 0.0
var initial_y : float = 0.0

func _ready():
	#First, lets save the initial target height (Y AXIS)
	#The oscliation will be relative to this first point
	#initial_y = global_position.y
	#TESTE
	# DICA DE OURO: Randomiza o tempo inicial.
	# Se você tiver 10 alvos, isso faz com que eles não subam e desçam
	# todos sincronizados igual um exército de robôs.
	time_passed = randf_range(0.0, 10.0)

func _process(delta):
	# Upload the movement clock
	time_passed += delta
	
	# Imma doing this in a special function to keep it clean, calling it
	apply_sine_movement(delta)


# --- SINE BEHAVIOR --- #
func apply_sine_movement(delta):
	 # 1. FOWARD MOVEMENT (Z AXIS)
	global_position += global_transform.basis.z * move_speed * delta
	
	# 2. CALCULATING THE SINE MOVEMENT (Y AXIS)
	# Formula: y = base_height + (sine(clock * velocity) * wave_size)
	# Obs.: i saw that formula on the internet
	var oscilation = sin(time_passed * frequency) * amplitude
	
	# 3. APPLYING THE NEW HEIGHT (i call this func in the _process func, so it uptades every tick)
	global_position.y = initial_y + oscilation
