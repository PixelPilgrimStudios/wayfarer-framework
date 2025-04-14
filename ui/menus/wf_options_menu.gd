# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

extends Control

var is_popup: bool = false
var locale_map = {
    0: "en",
    1: "es",
    2: "de",
    3: "fr",
    4: "pt_BR",
    5: "zh_CN",
    6: "ja"
}
@onready var back_button: Node = $VBoxContainer/BackButton
@onready var volume_slider: Node = $VBoxContainer/HBoxContainer/VolumeSlider
@onready var language_selector: Node = $VBoxContainer/HBoxContainer2/LanguageSelector


func _ready() -> void:
    is_popup = get_tree().current_scene != self
    if is_popup:
       $".".set_anchors_preset(Control.PRESET_FULL_RECT, false)
    refresh_translations()
    if not back_button.is_connected("pressed", Callable(self, "_on_back_pressed")):
        back_button.pressed.connect(_on_back_pressed)
    volume_slider.value = SettingsManager.volume
    language_selector.clear()
    language_selector.add_item(tr("English"), 0)
    language_selector.add_item(tr("Español"), 1)
    language_selector.add_item(tr("Deutsch"), 2)
    language_selector.add_item(tr("Français"), 3)
    language_selector.add_item(tr("Português (BR)"), 4)
    language_selector.add_item(tr("中文"), 5)
    language_selector.add_item(tr("日本語"), 6)
    for i in locale_map.size():
        if locale_map[i] == SettingsManager.locale:
            language_selector.selected = i
            break
    language_selector.item_selected.connect(_on_language_selected)
    refresh_translations()
    refresh_language_selector_labels()


func _on_volume_changed(value: float) -> void:
    SettingsManager.volume = value
    AudioManager.update_volume()
    SettingsManager.save()


func _on_language_selected(index: int) -> void:
    var selected_locale: String = locale_map.get(index, "en")
    SettingsManager.locale = selected_locale
    SettingsManager.save()
    var path: String = "res://translations/%s.tres" % selected_locale
    if ResourceLoader.exists(path):
        LocalizationManager.load_translation(path)
        await get_tree().process_frame
        refresh_translations()
        refresh_language_selector_labels()


func refresh_translations() -> void:
    back_button.text = tr("back")
    $VBoxContainer/HBoxContainer/VolumeLabel.text = tr("volume")
    $VBoxContainer/HBoxContainer2/LanguageLabel.text = tr("language")


func refresh_language_selector_labels() -> void:
    language_selector.set_item_text(0, tr("English"))
    language_selector.set_item_text(1, tr("Español"))
    language_selector.set_item_text(2, tr("Deutsch"))
    language_selector.set_item_text(3, tr("Français"))
    language_selector.set_item_text(4, tr("Português (BR)"))
    language_selector.set_item_text(5, tr("中文"))
    language_selector.set_item_text(6, tr("日本語"))


func _on_back_pressed() -> void:
    if is_popup:
        visible = false
    else:
        SceneLoader.change_scene("res://ui/menus/wf_main_menu.tscn")
