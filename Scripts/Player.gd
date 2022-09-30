extends KinematicBody2D

export var gravitation = 20
export var speed = Vector2(200, 500)
var movement = Vector2.ZERO
var count = 2

func _process(delta):
	if not is_on_floor():
		movement.y += gravitation
	if is_on_floor():
		movement = Vector2.ZERO
		count = 2
	
func _physics_process(delta):	
	# Gerak horizontal
	if Input.is_action_pressed("kanan") and not Input.is_action_pressed("kiri"):
		movement.x = speed.x
	else:
		movement.x = 0
		
	if Input.is_action_pressed("kiri") and not Input.is_action_pressed("kanan"):
		movement.x = -speed.x
			
	# Gerak vertikal
	if Input.is_action_just_pressed("atas") and count > 0:
		movement.y = -speed.y
		count -= 1
	if Input.is_action_pressed("bawah"):
		movement.y = 2 * speed.y
	if is_on_ceiling():
		movement.y *= -1
		
	move_and_slide(movement, Vector2.UP)
	
	if movement.x == 0 and is_on_floor():
		$AnimatedSprite.play("idle")
	elif Input.is_action_pressed("kanan") and movement.y <= gravitation:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	elif movement.x < 0 and movement.y <= gravitation:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")		
	elif not is_on_floor():
		$AnimatedSprite.play("jump")
