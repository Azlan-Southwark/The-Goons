extends CharacterBody2D
const Bulletpath = preload("res://Assets/Bullet.tscn")
@onready var anim = $AnimationTree
@export var Speed = 100
@export var Ammo = 10
var WeaponSlot = 1


func _ready():
	anim.active = true

func _physics_process(delta):
	$"../UI/Ammo".text = str(Ammo)
	WeaponSlot = wrap(WeaponSlot,0,5)
	#AIM AT MOUSE
	$Weapons.look_at(get_global_mouse_position())
	#MOVEMENT
	if Input.is_action_pressed("Walk Down"):
		anim.set("parameters/Walk/transition_request", "Walk Down")
		velocity.y += Speed
	if Input.is_action_pressed("Walk Up"):
		anim.set("parameters/Walk/transition_request", "Walk Up")
		velocity.y += -Speed
	if Input.is_action_pressed("Walk Right"):
		anim.set("parameters/Walk/transition_request", "Walk Right")
		velocity.x += Speed
	if Input.is_action_pressed("Walk Left"):
		anim.set("parameters/Walk/transition_request", "Walk Left")
		velocity.x += -Speed
	velocity.x = clampf(velocity.x, -250, 250)
	velocity.y = clampf(velocity.y, -250, 250)
	#Friction
	velocity.x = move_toward(velocity.x, 0, 10)
	velocity.y = move_toward(velocity.y, 0, 10)
	#SHOOT

	if Input.is_action_just_pressed("Weapon Slot 1"):
		WeaponSlot = 1
	if Input.is_action_just_pressed("Weapon Slot 2"):
		WeaponSlot = 2
	match WeaponSlot:
		1:
			$Weapons/Gun.visible = true
			$Weapons/Sword.visible = false
			if Input.is_action_just_pressed("Shoot"):
				Fire()
		2:
			$Weapons/Sword .visible = true
			$Weapons/Gun.visible = false
			if Input.is_action_just_pressed("Shoot"):
				Swing()
	#APPLY PHYISICS
	move_and_slide()

func _on_area_2d_area_entered(area : Area2D):
	if area.is_in_group("Ammo"):
		area.get_parent().queue_free()
		Ammo += 10
	if area.is_in_group("Health"):
		area.get_parent().queue_free()
		$Health.value += 10
	pass

func Fire():
	var Bullet = Bulletpath.instantiate()
	if Ammo > 0 :
		get_parent().add_child(Bullet)
		Bullet.position = $Weapons/Marker2D.global_position
		Bullet.rotation = $Weapons/Marker2D.global_rotation
		Bullet.velocity = get_global_mouse_position() - Bullet.position
		Bullet.velocity = $Weapons/Marker2D.global_transform.x * 500
		#KnockBck
		velocity += -$Weapons/Marker2D.global_transform.x * 5000
		Ammo -= 1
	
func Swing():
	$Weapons/AnimationPlayer.play("Sword Swing")

func _on_area_2d_area_exited(area):
	pass
