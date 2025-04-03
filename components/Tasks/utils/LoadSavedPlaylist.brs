function loadSavedPlaylist() as object
    reg = CreateObject("roRegistrySection", "SavedPlaylist")
    savedData = reg.Read("playlist")
    if savedData <> invalid and savedData <> ""
        return ParseJson(savedData)
    end if
    return invalid
end function