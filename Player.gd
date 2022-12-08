extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int) var JUMP_STRENGTH = -250
export(int) var JUMP_RELEASE_STRENGTH = -70
export(int) var MAX_SPEED = 100
export(int) var ACCELERATION = -15
export(int) var FRICTION = 15
export(int) var GRAVITY = 10

var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	apply_gravity()
	
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		apply_friction()
	else:
		apply_acceleration(input.x)
		
		if input.x > 0:
			get_node("AnimatedSprite").set_flip_h(true)
		else:
			get_node("AnimatedSprite").set_flip_h(false)
	
#	if Input.is_key_pressed(KEY_A):
#		get_node("AnimatedSprite").set_flip_h(false)
#		velocity.x = -80
#	elif Input.is_key_pressed(KEY_D):
#		get_node("AnimatedSprite").set_flip_h(true)
#		velocity.x = 80
#	else:
#		velocity.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_STRENGTH
	else:
		if Input.is_action_just_released("ui_up") and velocity.y < -80:
			velocity.y = -80
			
	velocity = move_and_slide(velocity, Vector2.UP)
	

func apply_gravity():
	velocity.y += 10
	
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 15)
	
func apply_acceleration(x_input):
	velocity.x = move_toward(velocity.x, 100 * x_input, 15)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
