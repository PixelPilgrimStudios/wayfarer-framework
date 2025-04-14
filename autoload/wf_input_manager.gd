# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends Node

var last_input_method: String = "keyboard"

func _unhandled_input(event) -> void:
    if event is InputEventKey:
        last_input_method = "keyboard"
    elif event is InputEventMouse:
        last_input_method = "mouse"
    elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
        last_input_method = "controller"
    elif event is InputEventScreenTouch or event is InputEventScreenDrag:
        last_input_method = "touch"
