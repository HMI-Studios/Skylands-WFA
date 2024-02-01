extends VBoxContainer


@export var action: String
@export var title: String


func _ready():
    assert(action)
    assert(title)
    
    $Title.text = title
    if len(InputMap.action_get_events(action)) > 0:
        $Btn.text = InputMap.action_get_events(action)[0].as_text()
    else:
        $Btn.text = "<Unassigned>"


func _on_btn_toggled(toggled_on):
    set_process_unhandled_input($Btn.button_pressed)
    if $Btn.button_pressed:
        $Btn.text = "<Press Key>"
        release_focus()
    else:
        $Btn.text = InputMap.action_get_events(action)[0].as_text()
        grab_focus()


func _unhandled_input(event):
    if is_instance_of(event, InputEventKey) and event.pressed and $Btn.button_pressed:
        InputMap.action_erase_events(action)
        InputMap.action_add_event(action, event)
        $Btn.text = InputMap.action_get_events(action)[0].as_text()
        if not (event.keycode == 32 or event.keycode == 4194309):
            $Btn.button_pressed = false
