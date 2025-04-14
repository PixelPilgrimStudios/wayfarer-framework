# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

extends CharacterBody2D

@export var speed: float = 120.0
@export var jump_force: float = 300.0
@export var gravity: float = 800.0


func _physics_process(delta):
    if not is_on_floor():
        velocity.y += gravity * delta
    else:
        velocity.y = 0.0
    var input_dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    velocity.x = input_dir * speed
    if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
        velocity.y = -jump_force
    move_and_slide()
