# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends Control

var splash = preload("res://assets/pixel_pilgrim_studios/pixelpilgrimstudios.mp3")
@onready var timer := $Timer


func _ready() -> void:
    var screen_size: Vector2 = get_viewport().get_visible_rect().size
    var scale_factor: float = min(screen_size.x, screen_size.y) / 128.0
    $CenterContainer/AnimatedSprite2D.scale = Vector2(scale_factor, scale_factor)
    timer.timeout.connect(_on_timer_timeout)
    timer.start(3.17)
    $CenterContainer/AnimatedSprite2D.play("default")
    AudioManager.play_sfx(splash)


func _on_timer_timeout() -> void:
    SceneLoader.change_scene("res://ui/menus/wf_main_menu.tscn")
