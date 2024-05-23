extends Sprite2D

@onready var Interact = $Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Interact.visible == true and Input.is_action_just_pressed("Interact"):
		Dialogic.start("Lad")

func _on_area_2d_area_entered(area):
	Interact.visible = true

func _on_area_2d_area_exited(area):
	Interact.visible = false
	Dialogic.end_timeline()
