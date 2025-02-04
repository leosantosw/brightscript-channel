sub init()
    m.title = m.top.findNode("title")
    m.focusBorder = m.top.findNode("focusBorder")
end sub

sub showContent()
    content = m.top.itemContent
    m.title.text = content.title
end sub

sub onFocusPercentChange()
    focusPercent = m.top.focusPercent
    m.focusBorder.opacity = focusPercent * 0.3
end sub