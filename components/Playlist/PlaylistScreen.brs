function init()
    m.playlistList = m.top.findNode("playlistList")
    m.refreshButton = m.top.findNode("refreshButton")
    m.refreshIcon = m.top.findNode("refreshIcon")
    m.spinner = m.top.getScene().findNode("spinner")
    m.playlistList.setFocus(true)
    loadContent()
end function

sub loadContent()
    m.contentTask = CreateObject("roSGNode", "GetPlaylistsTask")
    m.contentTask.ObserveField("playlists", "OnMainContentLoaded")
    m.contentTask.control = "run"
    m.spinner.visible = true
end sub

sub OnMainContentLoaded()
    m.spinner.visible = false
    playlists = m.contentTask.playlists
    if playlists <> invalid
        content = CreateObject("roSGNode", "ContentNode")
        
        for each playlist in playlists
            item = content.CreateChild("ContentNode")
            item.title = playlist.name
            item.description = FormatJson(playlist)
        end for
        
        m.playlistList.content = content
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then
        if key = "back"
            return false
        else if key = "right" or key = "up"
            if m.playlistList.hasFocus()
                m.refreshButton.setFocus(true)
                m.refreshIcon.blendColor = "#0072D2"
                return true
            end if
        else if key = "left" or key = "down"
            if m.refreshButton.hasFocus()
                m.playlistList.setFocus(true)
                m.refreshIcon.blendColor = "#FFFFFF"
                return true
            end if
        else if key = "OK"
            if m.refreshButton.hasFocus()
                print "Refreshing playlists..."
                loadContent()
                return true
            else if m.playlistList.hasFocus()
                playlist = m.playlistList.content.getChild(m.playlistList.itemSelected)
                playlistData = playlist.description
                savePlaylist(playlistData)
                print "Playlist data: "; ParseJson(playlist.description) 
                return false
            end if
        end if
    end if
    return true
end function 

sub savePlaylist(data as String)
    reg = CreateObject("roRegistrySection", "SavedPlaylist")
    reg.Write("playlist", data)
    reg.Flush()
end sub