# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

@tool
extends PopupPanel

@onready var english_button: Node = $VBoxContainer/Languages/English
@onready var spanish_button: Node = $VBoxContainer/Languages/Spanish
@onready var german_button: Node = $VBoxContainer/Languages/German
@onready var french_button: Node = $VBoxContainer/Languages/French
@onready var portuguese_button: Node = $VBoxContainer/Languages/Portuguese
@onready var chinese_button: Node = $VBoxContainer/Languages/Chinese
@onready var japanese_button: Node = $VBoxContainer/Languages/Japanese
@onready var translations_list: Node = VBoxContainer.new()
@onready var current_locale: String = "en"


func _ready() -> void:
    _add_controls()
    translations_list.name = "TranslationsList"
    translations_list.size_flags_vertical = Control.SIZE_EXPAND_FILL
    $VBoxContainer.add_child(translations_list)
    english_button.pressed.connect(func(): _set_language("en"))
    spanish_button.pressed.connect(func(): _set_language("es"))
    german_button.pressed.connect(func(): _set_language("de"))
    french_button.pressed.connect(func(): _set_language("fr"))
    portuguese_button.pressed.connect(func(): _set_language("pt_BR"))
    chinese_button.pressed.connect(func(): _set_language("zh_CN"))
    japanese_button.pressed.connect(func(): _set_language("ja"))
    _set_language("en")


func _set_language(locale: String) -> void:
    $VBoxContainer/LocaleLabel.text = "Editing: %s" % locale
    var path = "res://translations/%s.tres" % locale
    if FileAccess.file_exists(path):
        current_locale = locale
        _load_translation_to_editor(locale)
    else:
        print("Translation file missing:", path)


func _load_translation_to_editor(locale: String) -> void:
    var path: String = "res://translations/%s.tres" % locale
    if ResourceLoader.exists(path, "Translation"):
        var t: Translation = ResourceLoader.load(path, "Translation")
        if t:
            for child in translations_list.get_children():
                child.queue_free()
            for key in t.get_message_list():
                var hbox = HBoxContainer.new()
                hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
                var key_label = Label.new()
                key_label.text = key
                key_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
                key_label.custom_minimum_size = Vector2(120, 0)
                hbox.add_child(key_label)
                var value_edit = LineEdit.new()
                value_edit.text = t.get_message(key)
                value_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
                value_edit.name = key
                hbox.add_child(value_edit)
                var delete_button = Button.new()
                delete_button.text = "🗑"
                delete_button.tooltip_text = "Delete this entry"
                delete_button.pressed.connect(func():
                    hbox.queue_free()
                )
                hbox.add_child(delete_button)
                translations_list.add_child(hbox)


func _add_controls() -> void:
    var controls = HBoxContainer.new()
    controls.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    var add_button = Button.new()
    add_button.text = "󠀫󠀫➕ Add Entry"
    add_button.pressed.connect(_on_add_entry_pressed)
    controls.add_child(add_button)
    var save_button = Button.new()
    save_button.text = "💾 Save Changes"
    save_button.pressed.connect(_on_save_pressed)
    controls.add_child(save_button)
    $VBoxContainer.add_child(controls)


func _on_add_entry_pressed():
    var hbox: Node = HBoxContainer.new()
    hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    var key_edit: Node = LineEdit.new()
    key_edit.placeholder_text = "New Key"
    key_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    hbox.add_child(key_edit)
    var value_edit: Node = LineEdit.new()
    value_edit.placeholder_text = "New Value"
    value_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    hbox.add_child(value_edit)
    var delete_button: Node = Button.new()
    delete_button.text = "🗑"
    delete_button.tooltip_text = "Delete this entry"
    delete_button.pressed.connect(func():
        hbox.queue_free()
    )
    hbox.add_child(delete_button)
    translations_list.add_child(hbox)


func _on_save_pressed() -> void:
    var updated_translation: Translation = Translation.new()
    updated_translation.set_locale(current_locale)
    for hbox in translations_list.get_children():
        var fields = hbox.get_children()
        if fields.size() >= 2:
            var key = fields[0].text if fields[0] is LineEdit else fields[0].text
            var value = fields[1].text
            if key.strip_edges() != "":
                updated_translation.add_message(key.strip_edges(), value.strip_edges())
    var path: String = "res://translations/%s.tres" % current_locale
    ResourceSaver.save(updated_translation, path)
    print("..:: Saved ", path, " ::..")
