sub InitScreenStack ()
    m.screenStack = []
end sub

sub ShowScreen(node as Object)
    prev = m.screenStack.peek()
    if prev <> invalid
        prev.visible = false
    end if

    m.top.appendChild(node)
    node.visible = true
    node.setFocus(true)
    m.screenStack.push(node)
    print "Prev: "; m.screenStack
end sub

sub BackScreen(node as object) 
    if node = invalid OR (m.screenStack.peek() <> invalid AND m.screenStack.peek().IsSameNode(node))
        last = m.screenStack.pop()
        last.visible = false
        m.top.removeChild(node)
        
        prev = m.screenStack.peek()
        if prev <> invalid
            prev.visible = true
            prev.setFocus(true)
        end if
    end if
end sub