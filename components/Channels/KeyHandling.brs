function onKeyEvent(key as string, press as boolean) as boolean
    handled = false

    if press then
        if key = "right"
            if m.categoriesList.hasFocus() and m.subcategoriesList.visible
                m.categoriesList.setFocus(false)
                m.subcategoriesList.setFocus(true)
                UpdateAllItemsFocusState(m.subcategoriesList)
                UpdateAllItemsFocusState(m.categoriesList)
                handled = true
            end if
        else if key = "left"
            if m.subcategoriesList.hasFocus()
                m.subcategoriesList.setFocus(false)
                m.categoriesList.setFocus(true)
                UpdateAllItemsFocusState(m.subcategoriesList)
                UpdateAllItemsFocusState(m.categoriesList)
                handled = true
            end if
        else if key = "back"
            if m.subcategoriesList.hasFocus()
                m.subcategoriesList.setFocus(false)
                m.categoriesList.setFocus(true)
                UpdateAllItemsFocusState(m.subcategoriesList)
                UpdateAllItemsFocusState(m.categoriesList)
                handled = true
            end if
        end if
    end if

    return handled
end function