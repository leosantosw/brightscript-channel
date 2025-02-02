function init()
    m.top.backgroundUri = ""
    m.top.backgroundColor = "#0E1420"
    m.buttons = CreateObject("roAssociativeArray")
    m.buttons.canais = m.top.findNode("canaisButton")
    m.buttons.filmes = m.top.findNode("filmesButton")
    m.buttons.series = m.top.findNode("seriesButton")
    m.buttons.playlist = m.top.findNode("playlistButton")
    m.buttons.config = m.top.findNode("configButton")
    
    m.borders = CreateObject("roAssociativeArray")
    m.borders.canais = m.top.findNode("canaisBorder")
    m.borders.filmes = m.top.findNode("filmesBorder")
    m.borders.series = m.top.findNode("seriesBorder")
    m.borders.playlist = m.top.findNode("playlistBorder")
    m.borders.config = m.top.findNode("configBorder")
    
    m.buttons.canais.setFocus(true)
    m.currentFocus = "canais"
    updateFocus()
end function

sub updateFocus()
    for each key in m.borders
        m.borders[key].opacity = 0
    end for
    m.borders[m.currentFocus].opacity = 1
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then
        nextFocus = invalid
        
        if key = "right" then
            if m.currentFocus = "canais" then
                nextFocus = "filmes"
            else if m.currentFocus = "filmes" then
                nextFocus = "series"
            else if m.currentFocus = "playlist" then
                nextFocus = "config"
            end if
        else if key = "left" then
            if m.currentFocus = "series" then
                nextFocus = "filmes"
            else if m.currentFocus = "config" then
                nextFocus = "playlist"
            else if m.currentFocus = "filmes" then
                nextFocus = "canais"
            else if m.currentFocus = "playlist" then
                nextFocus = "canais"
            end if
        else if key = "down" then
            if m.currentFocus = "filmes" then
                nextFocus = "playlist"
            else if m.currentFocus = "series" then
                nextFocus = "config"
            else if m.currentFocus = "canais" then
                nextFocus = "filmes"
            end if
        else if key = "up" then
            if m.currentFocus = "playlist" then
                nextFocus = "filmes"
            else if m.currentFocus = "config" then
                nextFocus = "series"
            else if m.currentFocus = "filmes" or m.currentFocus = "series" then
                nextFocus = "canais"
            end if
        end if
        
        if nextFocus <> invalid then
            m.currentFocus = nextFocus
            m.buttons[nextFocus].setFocus(true)
            updateFocus()
            return true
        end if
    end if
    return false
end function