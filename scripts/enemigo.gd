extends CharacterBody2D

var velocidad = 40   
var direccion = 1     
var tiempo = 0.0      


func _physics_process(delta):

	velocity.y += get_gravity().y * delta

	velocity.x = direccion * velocidad
	move_and_slide()


	tiempo += delta
	if tiempo > 3:
		tiempo = 0
		direccion = -direccion
		$Sprite2D.flip_h = direccion < 0  #


func _on_hitbox_body_entered(body):
	body.die()
