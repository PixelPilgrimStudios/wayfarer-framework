# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

class_name WFSfxButton
extends Button

var click_sfx = preload("res://assets/sounds/select.ogg")
var hover_sfx = preload("res://assets/sounds/hover.ogg")


func _ready() -> void:
    connect("mouse_entered", _on_mouse_entered)
    connect("pressed", _on_pressed)


func _on_mouse_entered() -> void:
    if hover_sfx:
        AudioManager.play_sfx(hover_sfx)


func _on_pressed() -> void:
    if click_sfx:
        AudioManager.play_sfx(click_sfx)
