# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

extends Control

@onready var timer := $Timer


func _ready() -> void:
    timer.timeout.connect(_on_timer_timeout)
    timer.start(3)


func _on_timer_timeout() -> void:
    SceneLoader.change_scene("res://ui/splash_screens/studio_splash_screen.tscn")
