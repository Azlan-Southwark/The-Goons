extends CharacterBody2D

@onready var anim = $AnimationTree
@export var Speed = 100

func _ready():
	anim.active = true

func _physics_process(delta):
	if Input.is_action_pressed("Walk Down"):
		anim.set("parameters/Walk/transition_request", "Walk Down")
		velocity.y = Speed
	if Input.is_action_pressed("Walk Up"):
		anim.set("parameters/Walk/transition_request", "Walk Up")
		velocity.y = -Speed
	if Input.is_action_pressed("Walk Right"):
		anim.set("parameters/Walk/transition_request", "Walk Right")
		velocity.x = Speed
	if Input.is_action_pressed("Walk Left"):
		anim.set("parameters/Walk/transition_request", "Walk Left")
		velocity.x = -Speed
	#Friction
	velocity.x = move_toward(velocity.x, 0, 10)
	velocity.y = move_toward(velocity.y, 0, 10)
	
	move_and_slide()
func _on_area_2d_area_entered(area : Area2D):
	if area.is_in_group("Crazy"):
		Dialogic.start("Lad")
		Dialogic.end_timeline()
	pass # Replace with function body.
