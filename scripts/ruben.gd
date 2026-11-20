extends CharacterBody2D

var velocidad = 120      # lo rápido que anda
var fuerza_salto = -300  # lo alto que salta (negativo = hacia arriba)
var muerto = false

@onready var sprite = $animacion  # el dibujo animado del personaje


func _physics_process(delta):
	# Si ha muerto, no hace nada más
	if muerto:
		return

	# Gravedad: lo hace caer cuando no está en el suelo
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Salto con la tecla Espacio, solo si está en el suelo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = fuerza_salto
		Sonido.play("salto")

	# Izquierda / derecha: da -1, 0 o 1
	var direccion = Input.get_axis("left", "right")
	velocity.x = direccion * velocidad
	move_and_slide()

	# Elige la animación
	if direccion != 0:
		sprite.flip_h = direccion < 0  # mira hacia donde anda
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
	await get_tree().create_timer(1.5).timeout  # espera 1,5 segundos
	get_tree().reload_current_scene()           # reinicia el nivel
