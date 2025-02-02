function init()
    m.categoriesList = m.top.findNode("categoriesList")
    m.categoriesList.setFocus(true)
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