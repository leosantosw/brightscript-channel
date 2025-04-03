sub init()
    m.labelText = m.top.findNode("labelText")
    m.background = m.top.findNode("background")
    m.border = m.top.findNode("border")
end sub

sub updateTitle()
    content = m.top.itemContent
    if content <> invalid and content.title <> invalid then
        cleanTitle = RemoveUnicode(content.title)
        m.labelText.text = cleanTitle
    end if
end sub

function RemoveUnicode(text as string) as string
    regex = CreateObject("roRegex", "[^\x20-\x7E]", "")
    return regex.ReplaceAll(text, "")
end function

sub showfocus()
    if m.top.focusPercent > 0
        parent = m.top.getParent()
        if parent.hasFocus()
            m.border.visible = true
            m.background.blendColor = "#192542"
        else
            m.border.visible = false
            m.background.blendColor = "#08111f"
        end if
    else
        m.border.visible = false
        m.background.blendColor = "#08111f"
    end if
end sub