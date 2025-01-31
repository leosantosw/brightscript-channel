sub Init ()
    m.top.SetField("backgroundColor", "#191a19")
    m.top.SetField("backgroundURI", "pkg:/images/background.jpg")
    
    m.gridContainer = m.top.findNode("gridContainer")
    centerx = (1280) / 2
    centery = (720) / 2
    m.gridContainer.translation = [ centerx, centery ]   
     
    m.focusRing = m.top.findNode("focusRing")
    m.nodesToFocus = [
        m.top.findNode("channels"),
        m.top.findNode("playlist"),
        m.top.findNode("settings"),
    ]

    m.nodesToFocus[0].setFocus(true)
    m.top.observeField("focusedChild", "onFocusedChildChange")
    ' InitSpinner()
end sub

sub onFocusedChildChange()
    focusedChild = m.top.focusedChild.focusedChild

    if focusedChild <> invalid and focusedChild.id <> "" then
        print "Currently focused element: " + focusedChild.id
        m.focusRing.translation = [
            focusedChild.translation[0] + 637,
            focusedChild.translation[1] + 356
        ]
        m.currentFocused = focusedChild.focusedChild.focusedChild.id
    end if
end sub

sub focusNextSibling()
    nodeToFocus = invalid

    'focus the next child
    for i = 0 to m.nodesToFocus.count() - 1
        child = m.nodesToFocus[i]
        'skip the focusRing
        if child.id = "focusRing"
            continue for
        end if

        if child.hasFocus()
            nodeToFocus = m.nodesToFocus[i + 1]
            exit for
        end if
    end for
    'if we have no node to focus, then focus the first node that's not the focusRing
    if nodeToFocus = invalid
        nodeToFocus = m.nodesToFocus[0]
    end if
    nodeToFocus.setFocus(true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    'only handle key up events
    if press <> true
        return false
    end if

    'simple focus management for now, just move forwards or backwards
    if key = "right"  or key = "left" ' or key = "down" or key = "up"
        focusNextSibling()
        return true
    end if

    if key = "OK" then
        print "OK key pressed, focused: ";  m.currentFocused 
        return true
    end if
    return false
end function
