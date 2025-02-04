sub init()
    m.title = m.top.findNode("title")
    m.focusBorder = m.top.findNode("focusBorder")
    m.trashButton = m.top.findNode("trashButton")
    m.trashIcon = m.top.findNode("trashIcon")
end sub

sub showContent()
    content = m.top.itemContent
    m.title.text = content.title
end sub

sub onFocusPercentChange()
    focusPercent = m.top.focusPercent
    m.focusBorder.opacity = focusPercent * 0.3
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then
        print "Key pressed: "; key
        if key = "back"
            return false
        else if key = "right" 
            m.trashButton.setFocus(true)
            m.trashIcon.blendColor = "#0072D2"
            return true
        end if
    end if
    return true
end function