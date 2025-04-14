# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends Control

@onready var timer := $Timer


func _ready() -> void:
    timer.timeout.connect(_on_timer_timeout)
    timer.start(3)


func _on_timer_timeout() -> void:
    SceneLoader.change_scene("res://ui/splash_screens/studio_splash_screen.tscn")
