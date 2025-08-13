extends CharacterBody2D

var speed = 100
var chase = false
@onready var player = get_node("../../player/Player")
@onready var cherry = preload("res://cherry.tscn")
@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta: float) -> void:
	if is_dead:
		move_and_slide()
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	if chase:
		anim.play("jump") 
		var direction = (player.global_position - self.global_position)
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			direction.x = 1
		else:
			get_node("AnimatedSprite2D").flip_h = false
			direction.x = -1
		velocity.x = direction.x * speed
		if velocity.y == 0:
			velocity.y = -400
	else:
		velocity.x = 0
		if velocity.y == 0:
			anim.play("idle")
	if velocity.y>0:
		anim.play("fall")
	move_and_slide()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		chase = true

func _on_frog_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		chase = false

var is_dead = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Fireball" and not is_dead:
		player.enemies -= 1
		anim.play("death")
		is_dead = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:	
	if anim_name == "death":
		var chery = cherry.instantiate()
		chery.global_position = global_position
		get_tree().current_scene.add_child(chery)
		queue_free()
