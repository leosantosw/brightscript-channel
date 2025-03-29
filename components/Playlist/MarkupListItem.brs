sub init()
    m.focusBg = m.top.findNode("focusBg")
    m.background = m.top.findNode("background")
    m.ItemBorder = m.top.findNode("item-border")
    m.playlistTitle = m.top.findNode("playlistTitle")
end sub

sub showContent()
    content = m.top.itemContent
    m.playlistTitle.text = content.title
end sub

sub showfocus(event)
    if m.top.focusPercent then
        m.focusBg.visible = true
        m.ItemBorder.visible = true
        m.playlistTitle.color = "#e9ebf0"
    else
        m.focusBg.visible = false
        m.ItemBorder.visible = false
        m.playlistTitle.color = "#e9ebf0"
    end if
end sub