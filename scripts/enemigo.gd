extends CharacterBody2D

const SPEED = 40.0
var dir := -1.0


func _physics_process(delta: float) -> void:
	velocity = Vector2(dir * SPEED, velocity.y + get_gravity().y * delta)
	move_and_slide()
	# Da la vuelta en una pared o en el borde de la plataforma
	if is_on_wall() or (is_on_floor() and not $RayCast2D.is_colliding()):
		dir = -dir
		$RayCast2D.position.x = 14 * dir
		$Sprite2D.flip_h = dir < 0


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.velocity.y > 0 and body.global_position.y < global_position.y - 14:
		Sonido.play("golpe")  # el jugador le salta encima
		body.rebotar()
		queue_free()
	else:
		body.die()
