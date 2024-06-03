extends CharacterBody2D

@onready var Interact = $Label
var interact = false

func _process(delta):
	if interact == true and Input.is_action_just_pressed("Interact"):
		Dialogic.start(""+self.name)
		interact = false
		Interact.visible = false

func _on_area_2d_area_entered(area):
	Interact.visible = true
	interact = true

func _on_area_2d_area_exited(area):
	Interact.visible = false
	interact = false
	Dialogic.end_timeline()
