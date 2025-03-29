function init()
    m.buttons = CreateObject("roAssociativeArray")
    m.buttons.channels = m.top.findNode("channelsButton")
    m.buttons.movies = m.top.findNode("moviesButton")
    m.buttons.series = m.top.findNode("seriesButton")
    m.buttons.playlist = m.top.findNode("playlistButton")
    m.buttons.settings = m.top.findNode("settingsButton")

    m.borders = CreateObject("roAssociativeArray")
    m.borders.channels = m.top.findNode("channelsBorder")
    m.borders.movies = m.top.findNode("moviesBorder")
    m.borders.series = m.top.findNode("seriesBorder")
    m.borders.playlist = m.top.findNode("playlistBorder")
    m.borders.settings = m.top.findNode("settingsBorder")

    m.buttons.channels.setFocus(true)
    m.currentFocus = "channels"
    updateFocus()
end function

sub updateFocus()
    for each key in m.borders
        m.borders[key].opacity = 0
    end for
    m.borders[m.currentFocus].opacity = 1
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press then
        nextFocus = invalid

        if key = "OK" then
            ClickButton(m.currentFocus)
            return true
        end if

        if key = "right" then
            if m.currentFocus = "channels" then
                nextFocus = "movies"
            else if m.currentFocus = "movies" then
                nextFocus = "series"
            else if m.currentFocus = "playlist" then
                nextFocus = "settings"
            end if
        else if key = "left" then
            if m.currentFocus = "series" then
                nextFocus = "movies"
            else if m.currentFocus = "settings" then
                nextFocus = "playlist"
            else if m.currentFocus = "movies" then
                nextFocus = "channels"
            else if m.currentFocus = "playlist" then
                nextFocus = "channels"
            end if
        else if key = "down" then
            if m.currentFocus = "movies" then
                nextFocus = "playlist"
            else if m.currentFocus = "series" then
                nextFocus = "settings"
            else if m.currentFocus = "channels" then
                nextFocus = "movies"
            end if
        else if key = "up" then
            if m.currentFocus = "playlist" then
                nextFocus = "movies"
            else if m.currentFocus = "settings" then
                nextFocus = "series"
            else if m.currentFocus = "movies" or m.currentFocus = "series" then
                nextFocus = "channels"
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

function ClickButton(buttonText as string)
    print "ClickButton: "; buttonText
    m.top.categorySelected = buttonText
end function
