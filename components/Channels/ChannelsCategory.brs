function init()
    m.categoriesList = m.top.findNode("categoriesList")
    m.categoriesList.setFocus(true)

    loadSavedPlaylist()
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then
        if key = "back"
            return false ' let main scene handle back
        else if key = "OK"
            category = m.categoriesList.content.getChild(m.categoriesList.itemSelected)
            print "Selected category: "; category.title
            return true
        end if
    end if
    return true
end function 

function loadSavedPlaylist() as Object
    reg = CreateObject("roRegistrySection", "SavedPlaylist")
    savedData = reg.Read("playlist")
    print "Received data: "; savedData
    
    if savedData <> invalid and savedData <> ""
        return ParseJson(savedData) ' Converte JSON para objeto
    end if

    return invalid
end function