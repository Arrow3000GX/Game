extends CharacterBody2D

@onready var player = get_node("../../player/Player")
@onready var cherry = preload("res://cherry.tscn")
@onready var anim = $AnimationPlayer

@onready var attack_area = $AttackArea 
@onready var attack_shape = $AttackArea/AttackHitbox

var face_left = true
var attacking = false

func _ready() -> void:
	attack_shape.disabled = true	
	if face_left:
		$AnimatedSprite2D.flip_h = true
		attack_area.scale.x = -1
	else:
		attack_area.scale.x = 1
		
	anim.connect("animation_started", Callable(self, "_on_animation_started"))
	anim.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _process(delta: float) -> void:
	if not attacking and anim.current_animation != "Idle":
		anim.play("Attack")
	print(player.health)
func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.name == "Player" and not attacking:
		anim.play("Attack")
		attacking = true

func _on_animation_started(anim_name: StringName) -> void:
	if anim_name == "Attack":
		attack_shape.disabled = false

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		attacking = false
		attack_shape.disabled = true


func _on_attack_area_body_entered(body: Node2D) -> void:
	print(body.name)
