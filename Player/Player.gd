extends KinematicBody2D

const FRICTION = 500
const ACCELERATON = 500
const MAX_SPEED = 80

var velocity = Vector2.ZERO

# onready var animation_player = $AnimationPlayer
var animation_player: AnimationPlayer = null

func _ready():
	animation_player = $AnimationPlayer

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() # clip the vector to factor of 1
	
	# multiply by delta to match real world time instead of each frame, in case the game lags
	if input_vector != Vector2.ZERO:
		# if input_vector.x > 0:
		#	animation_player.play("RunRight")
		#else:
		#	animation_player.play("RunLeft")
		animation_player.play("RunRight" if input_vector.x > 0 else "RunLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATON * delta)
	else:
		animation_player.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)
	# move_and_slide(velocity) move_and_side() ALREADY use delta, do not multiply velocity by delta if use it
