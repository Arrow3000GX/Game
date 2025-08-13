extends CharacterBody2D
@onready var anim = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Open")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		anim.play("Close")

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		anim.play("Close")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Open":
		anim.play("Idle")
	if anim_name == "Close":
		get_tree().change_scene_to_file("res://win.tscn")
