# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

extends Node

func _ready() -> void:
    var console: Node = preload("res://debug/wf_dev_console.tscn").instantiate()
    get_tree().get_root().call_deferred("add_child", console)
