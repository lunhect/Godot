extends CharacterBody2D

var velocidad = 120      
var fuerza_salto = -300  
var muerto = false

@onready var sprite = $animacion  

func _physics_process(delta):
	if muerto:
		return

	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = fuerza_salto
		Sonido.play("salto")

	
	var direccion = Input.get_axis("left", "right")
	velocity.x = direccion * velocidad
	move_and_slide()

	if direccion != 0:
		sprite.flip_h = direccion < 0  
	if not is_on_floor():
		sprite.play("jump")
	elif direccion != 0:
		sprite.play("run")
	else:
		sprite.play("idle")


func die():
	if muerto:
		return
	muerto = true
	sprite.play("fail")
	Sonido.play("muerte")
	await get_tree().create_timer(1.5).timeout  
	get_tree().reload_current_scene()          
