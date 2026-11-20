extends CharacterBody2D

const SPEED = 40.0

var dir := -1.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var suelo: RayCast2D = $RayCast2D


func _ready() -> void:
	$Hitbox.body_entered.connect(_on_hitbox_body_entered)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = dir * SPEED
	move_and_slide()

	# Da la vuelta al chocar con una pared o al llegar al borde de la plataforma
	if is_on_wall() or (is_on_floor() and not suelo.is_colliding()):
		dir = -dir
	sprite.flip_h = dir < 0
	suelo.position.x = 14 * dir


func _on_hitbox_body_entered(body: Node) -> void:
	if not body.has_method("die"):
		return
	if body.velocity.y > 0 and body.global_position.y < global_position.y - 14:
		Sonido.play("golpe")  # el jugador le salta encima
		body.rebotar()
		queue_free()
	else:
		body.die()
