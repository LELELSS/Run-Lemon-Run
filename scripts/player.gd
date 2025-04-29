extends CharacterBody2D


const SPEED = 110.0
const RUN = 180.0

const JUMP_VELOCITY = -300.0 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_dead = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound


func _physics_process(delta: float) -> void:

	if is_dead:
		return # Stop movement if dead

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	var is_running := Input.is_action_pressed("run")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	
		
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		elif is_running:
			animated_sprite_2d.play("run")
		else: 
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")
		
	# Adjust speed based on running
	var current_speed = RUN if is_running else SPEED
	
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
func die():
	is_dead = true # Stop player movement
	animated_sprite_2d.play("death")
	death_sound.play()
	
