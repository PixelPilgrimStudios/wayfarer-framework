# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

extends CanvasLayer

var enabled: bool = false
@onready var output: Node = $OutputLabel
@onready var input: Node = $LineEdit


func _ready() -> void:
    var args = OS.get_cmdline_args()
    enabled = "--dev" in args
    visible = false
    set_process_input(enabled)
    hide()
    input.text_submitted.connect(_on_input_submitted)


func toggle() -> void:
    visible = not visible
    if visible:
        input.grab_focus()


func _on_input_submitted(command: String) -> void:
    output.text += "\n> " + command
    match command.strip_edges():
        "help":
            output.text += "\n❓ Available commands:\n help\n set_volume <value between 0.0 and 1.0>\n touch_controls on|off|toggle"
        "set_volume":
            SettingsManager.volume = 0.5
            AudioManager.update_volume()
            output.text += "\n🔊 Volume set to 0.5"
        "clear":
            output.text = ""
        "exit":
            toggle()
        "quit":
            toggle()
        "reset_settings":
            _reset_settings()
        "touch_controls on":
            SettingsManager.touch_controls_enabled = true
            SettingsManager.save()
            output.text += "\n🖲 Touch Controls enabled."
            if has_node("/root/TouchControls"):
                $"/root/TouchControls".refresh()
        "touch_controls off":
            SettingsManager.touch_controls_enabled = false
            SettingsManager.save()
            output.text += "\n🖲 Touch Controls disabled."
            if has_node("/root/TouchControls"):
                $"/root/TouchControls".refresh()
        "touch_controls toggle":
            SettingsManager.touch_controls_enabled = !SettingsManager.touch_controls_enabled
            SettingsManager.save()
            output.text += "\n🖲 Touch Controls toggled to: " + str(SettingsManager.touch_controls_enabled)
            if has_node("/root/TouchControls"):
                $"/root/TouchControls".refresh()
        _:
            output.text += "\nUnknown command"
    input.text = ""


func _reset_settings() -> void:
    var dir: DirAccess = DirAccess.open("user://")
    if dir and dir.file_exists("settings.cfg"):
        dir.remove("settings.cfg")
        output.text += "\n✅ Settings wiped."
    else:
        output.text += "\n⚠ No settings file found to delete."
    SettingsManager.load_settings()
    output.text += "\n🔁 Settings reloaded."


func _unhandled_input(event) -> void:
    if not enabled:
        return
    if event is InputEventKey and event.pressed and event.keycode == 96:
        toggle()
