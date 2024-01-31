extends VBoxContainer


@export var action: String
@export var title: String

var button_pressed = false


func _ready():
    assert(action)
    assert(title)
    
    $Title.text = title
    if len(InputMap.action_get_events(action)) > 0:
        $Btn.text = InputMap.action_get_events(action)[0].as_text()
    else:
        $Btn.text = "<Unassigned>"


func _on_btn_toggled(toggled_on):
    button_pressed = toggled_on
    set_process_unhandled_input(button_pressed)
    if button_pressed:
        $Btn.text = "<Press Key>"
        release_focus()
    else:
        $Btn.text = InputMap.action_get_events(action)[0].as_text()
        grab_focus()


func _unhandled_input(event):
    if is_instance_of(event, InputEventKey) and event.pressed and button_pressed:
        InputMap.action_erase_events(action)
        InputMap.action_add_event(action, event)
        button_pressed = false
        $Btn.text = InputMap.action_get_events(action)[0].as_text()
