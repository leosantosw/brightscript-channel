sub Init()
    m.btnBack = m.top.FindNode("border-back-back")
    m.btnUse = m.top.FindNode("border-use-back")

    m.currentFocusedButton = "back"
    UpdateButtonFocus()
end sub

sub UpdateButtonFocus()
    m.btnBack.visible = false
    m.btnUse.visible = false

    if m.currentFocusedButton = "back" then
        m.btnBack.visible = true
    else if m.currentFocusedButton = "useList" then
        m.btnUse.visible = true
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "right" then
        if m.currentFocusedButton = "back" then
            m.currentFocusedButton = "useList"
            UpdateButtonFocus()
            return true
        end if
    else if key = "left" then
        if m.currentFocusedButton = "useList" then
            m.currentFocusedButton = "back"
            UpdateButtonFocus()
            return true
        end if
    else if key = "OK" then
        if m.currentFocusedButton = "back" then
            m.top.dialogOption = false
            return true
        else if m.currentFocusedButton = "useList" then
            m.top.dialogOption = true
            return true
        end if
    end if

    return false
end function
