extends CharacterBody2D
func _physics_process(delta):
	if velocity.length() < 1:
		velocity *= 5
	move_and_slide()
