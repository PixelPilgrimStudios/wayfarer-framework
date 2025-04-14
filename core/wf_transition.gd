# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends CanvasLayer

signal fade_out_complete
@onready var anim: Node = $AnimationPlayer


func fade_out() -> void:
    if anim:
        anim.play("fade_out")


func fade_in() -> void:
    if anim:
        anim.play("fade_in")


func _on_animation_finished(anim_name: String) -> void:
    if anim_name == "fade_out":
        emit_signal("fade_out_complete")
    elif anim_name == "fade_in":
        queue_free()
