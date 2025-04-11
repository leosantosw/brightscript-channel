sub OnCategoryFocused(event)
    index = event.getData()
    UpdateAllItemsFocusState(m.categoriesList)

    if m.categoriesList.hasFocus()
        m.categoriesList.jumpToItem = index
        m.categoriesList.itemFocused = index
    end if
end sub

sub OnSubcategoryFocused(event)
    index = event.getData()
    focusedItem = m.subcategoriesList.content.getChild(index)
    print ParseJson(focusedItem.description)
    ' load epg component here

    UpdateAllItemsFocusState(m.subcategoriesList)

    if m.subcategoriesList.hasFocus()
        m.subcategoriesList.jumpToItem = index
        m.subcategoriesList.itemFocused = index
    end if
end sub

sub UpdateAllItemsFocusState(list as object)
    content = list.content
    if content = invalid then return

    listHasFocus = list.hasFocus()
    currentFocusedIndex = list.itemFocused

    for i = 0 to content.getChildCount() - 1
        item = content.getChild(i)
        if not item.hasField("isSelected") then item.addFields({
            isSelected: (i = currentFocusedIndex),
            listHasFocus: listHasFocus
        })
        item.isSelected = (i = currentFocusedIndex)
        item.listHasFocus = listHasFocus
    end for
end sub