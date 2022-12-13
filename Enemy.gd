extends KinematicBody2D

onready var enemyAnimatedSprite = $AnimatedSprite
onready var ledgeCheckRight: = $LedgeCheckRight
onready var ledgeCheckLeft: = $LedgeCheckLeft

var direction = Vector2.LEFT
var velocity = Vector2.ZERO

func _physics_process(_delta):
	var found_wall = is_on_wall()
	var found_ledge = not (ledgeCheckRight.is_colliding() and ledgeCheckLeft.is_colliding())
	
	if found_wall or found_ledge:
		direction *= -1
		print(direction)
	
	enemyAnimatedSprite.flip_h = direction.x > 0

	velocity = direction * 25
	move_and_slide(velocity, Vector2.UP)
