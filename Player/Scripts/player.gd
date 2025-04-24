class_name Player
extends CharacterBody2D

var move_speed: float = 100.0

@onready var sprite := $Sprite2D
@onready var animation_player := $AnimationPlayer

func _physics_process(delta):
	var direction: Vector2 = Vector2.ZERO

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	direction = direction.normalized()
	velocity = direction * move_speed

	move_and_slide()
	_update_animation(direction)

func _update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		# Not moving — play idle based on last direction
		match animation_player.current_animation:
			"walk_up":
				animation_player.play("idle_up")
			"walk_down":
				animation_player.play("idle_down")
			"walk_side":
				animation_player.play("idle_side")
		return

	# Moving — play walk animation
	if abs(direction.x) > abs(direction.y):
		# Horizontal movement
		sprite.flip_h = direction.x > 0  # Flip if moving right (sprite faces LEFT by default)
		animation_player.play("walk_side")
	elif direction.y < 0:
		animation_player.play("walk_up")
	else:
		animation_player.play("walk_down")
