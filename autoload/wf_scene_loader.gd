# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

extends Node

signal scene_changed(scene_name)
var _transition: Node = null
@onready var transition_scene := preload("res://core/wf_transition.tscn")


func change_scene(path: String) -> void:
    if _transition:
        _transition.queue_free()
    _transition = transition_scene.instantiate()
    get_tree().get_root().call_deferred("add_child", _transition)
    _transition.layer = 100
    await _transition.ready
    _transition.fade_out()
    await _transition.fade_out_complete
    get_tree().change_scene_to_file(path)
    await get_tree().process_frame
    emit_signal("scene_changed", path)
    _transition.fade_in()
