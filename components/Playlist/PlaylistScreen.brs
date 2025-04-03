function init()
    m.spinner = m.top.getScene().findNode("spinner")
    m.playlistId = m.top.findNode("playlistId")
    m.playlistId.observeField("itemSelected", "OnItemSelected")
    m.playlistId.setFocus(true)
    loadContent()
end function

sub loadContent()
    m.spinner.visible = true
    m.contentTask = CreateObject("roSGNode", "GetPlaylistsTask")
    m.contentTask.ObserveField("playlists", "OnMainContentLoaded")
    m.contentTask.control = "run"
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

sub OnItemSelected()
    m.selectedTitle = m.playlistId.content.getChild(m.playlistId.itemSelected)
    m.playlistDialog = CreateObject("roSGNode", "PlaylistDialog")
    m.top.AppendChild(m.playlistDialog)
    m.playlistDialog.SetFocus(true)
    m.playlistDialog.observeField("dialogOption", "onDialogOptionSelected")
end sub

sub onDialogOptionSelected()
    if m.playlistDialog.dialogOption then
        savePlaylist(m.selectedTitle.description)
        m.top.navigateToHome = true
    end if

    m.top.RemoveChild(m.playlistDialog)
    m.playlistId.setFocus(true)
end sub

sub savePlaylist(data as string)
    reg = CreateObject("roRegistrySection", "SavedPlaylist")
    reg.Write("playlist", data)
    reg.Flush()
end sub