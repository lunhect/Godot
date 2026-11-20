extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0

var was_on_floor := true
var dead := false

@onready var sprite: AnimatedSprite2D = $animacion


func _ready() -> void:
	sprite.sprite_frames.set_animation_loop("jump_landing", false)


func _physics_process(delta: float) -> void:
	if dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		Sonido.play("salto")

	var dir := Input.get_axis("left", "right")
	velocity.x = dir * SPEED
	move_and_slide()

	if dir:
		sprite.flip_h = dir < 0

	if not is_on_floor():
		sprite.play("jump")
	elif not was_on_floor:
		sprite.play("jump_landing")
		Sonido.play("aterrizaje")
	elif dir or not (sprite.animation == "jump_landing" and sprite.is_playing()):
		sprite.play("run" if dir else "idle")

	was_on_floor = is_on_floor()


func rebotar() -> void:
	velocity.y = JUMP_VELOCITY * 0.7


func die() -> void:
	if dead:
		return
	dead = true
	velocity = Vector2.ZERO
	sprite.play("fail")
	Sonido.play("muerte")
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()
