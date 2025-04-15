sub init()
    m.labelText = m.top.findNode("labelText")
    m.background = m.top.findNode("background")
    m.border = m.top.findNode("border")
    m.top.ObserveField("itemFocused", "OnItemFocusedChanged")

    m.top.observeField("itemContent", "onItemContentChanged")
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

sub onItemContentChanged()
    content = m.top.itemContent
    if content = invalid then return

    if content.hasField("isSelected") and content.hasField("listHasFocus")
        updateItemAppearance(content.isSelected, content.listHasFocus)
    end if
end sub

sub updateItemAppearance(isSelected as boolean, listHasFocus as boolean)
    if isSelected
        if listHasFocus
            m.background.blendColor = "#02d6e8"
            m.labelText.color = "#31343E"
            m.border.visible = true
        else
            m.background.blendColor = "#31343E"
            m.labelText.color = "#02d6e8"
            m.border.visible = false
        end if
    else
        m.background.blendColor = "#13151D"
        m.border.visible = false
        m.labelText.color = "#FFFFFF"
    end if
end sub
