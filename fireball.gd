extends CharacterBody2D

var SPEED = 500
var direction: int = 1
var has_hit = false
var stopped = false

@onready var anim = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	anim.play("Flying ball")
	sprite.flip_h = direction < 0

func _physics_process(_delta: float) -> void:
	if not stopped:
		velocity = Vector2(direction * SPEED, 0)
		move_and_slide()

		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()

			if not has_hit:
				_on_hit()

func _on_fireball_area_entered(area: Area2D) -> void:
	if has_hit:
		return
	var ignored_areas = ["HitArea", "DetectionArea", "AttackArea", "cherry", "Fireball", "Player"]
	if area.name in ignored_areas:
		return

	_on_hit()

func _on_hit() -> void:
	has_hit = true	
	stopped = true
	velocity = Vector2.ZERO
	anim.play("hit")
	await get_tree().create_timer(0.05).timeout
	$CollisionShape2D.call_deferred("set_disabled", true)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		queue_free()
