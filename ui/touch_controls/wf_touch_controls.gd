# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

extends CanvasLayer

func _ready() -> void:
    $LeftStick/LeftButton.pressed.connect(func():
        Input.action_press("ui_left")
    )
    $LeftStick/LeftButton.released.connect(func():
        Input.action_release("ui_left")
    )
    $LeftStick/RightButton.pressed.connect(func():
        Input.action_press("ui_right")
    )
    $LeftStick/RightButton.released.connect(func():
        Input.action_release("ui_right")
    )
    $AButton/TouchScreenButton.pressed.connect(func():
        Input.action_press("ui_accept")
    )
    $AButton/TouchScreenButton.released.connect(func():
        Input.action_release("ui_accept")
    )
