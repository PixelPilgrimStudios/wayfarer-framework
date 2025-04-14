# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends Control

@onready var back_button = $MarginContainer/VBoxContainer/BackButton
@onready var credits_label = $MarginContainer/VBoxContainer/CreditsText


func _ready() -> void:
    back_button.text = tr("back")
    credits_label.text = tr("credits_text").replace("\\n","\n")
    back_button.pressed.connect(_on_back_pressed)

func _on_back_pressed() -> void:
    SceneLoader.change_scene("res://ui/menus/wf_main_menu.tscn")
