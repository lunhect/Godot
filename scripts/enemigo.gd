extends CharacterBody2D

var velocidad = 40    # lo rápido que anda
var direccion = 1     # 1 = derecha, -1 = izquierda
var tiempo = 0.0      # segundos que lleva andando hacia un lado


func _physics_process(delta):
	# Gravedad: lo hace caer hasta el suelo
	velocity.y += get_gravity().y * delta

	# Anda hacia el lado de "direccion"
	velocity.x = direccion * velocidad
	move_and_slide()

	# Cada 3 segundos da la vuelta
	tiempo += delta
	if tiempo > 3:
		tiempo = 0
		direccion = -direccion
		$Sprite2D.flip_h = direccion < 0  # gira el dibujo


func _on_hitbox_body_entered(body):
	# Si el jugador lo toca, el jugador muere
	body.die()
