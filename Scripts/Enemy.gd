extends KinematicBody2D

export var gravitation = 20
export var speed = -100
var movement = Vector2(speed, 0)
var count = 2

func _ready():
	pass

func _process(delta):
	if not is_on_floor():
		movement.y += gravitation
	else:
		movement.y = 0
	
func _physics_process(delta):	
	# Gerak horizontal
	if is_on_wall():
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$RayCast2D.cast_to.x *= -1 
		movement.x = -movement.x

	# Gerak vertikal
	if $RayCast2D.is_colliding():
		movement.y = -600

	move_and_slide(movement, Vector2.UP)

func _on_Hit_body_entered(body):
	body.get_tree().reload_current_scene()

func _on_Die_body_entered(body):
	self.queue_free()
	body.movement.y = -300
