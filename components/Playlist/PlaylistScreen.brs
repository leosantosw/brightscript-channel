function init()
    m.spinner = m.top.getScene().findNode("spinner")
    m.playlistId = m.top.findNode("playlistId")
    m.playlistId.setFocus(true)
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

        m.playlistId.content = content
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press then
        if key = "back"
            return false
        end if
    end if
    ' else if key = "OK"
    ' if m.refreshButton.hasFocus()
    '     loadContent()
    '     return true
    ' else if m.playlistList.hasFocus()
    '     playlist = m.playlistList.content.getChild(m.playlistList.itemSelected)
    '     playlistData = playlist.description
    '     savePlaylist(playlistData)
    '     m.top.playlistSaved = true
    '     return true
    return true
end function

' sub savePlaylist(data as string)
'     reg = CreateObject("roRegistrySection", "SavedPlaylist")
'     reg.Write("playlist", data)
'     reg.Flush()
' end sub