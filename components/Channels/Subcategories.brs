sub OnCategorySelected()
    index = m.categoriesList.itemSelected
    selectedItem = m.categoriesList.content.getChild(index)
    categoryData = ParseJson(selectedItem.description)
    LoadSubcategories(categoryData.category_id)
end sub

sub LoadSubcategories(categoryId as string)
    m.subcategoriesList.visible = false
    m.spinner.visible = true
    m.spinner.translation = [390, 250]
    m.subcategoriesTask = CreateObject("roSGNode", "SubcategoriesTask")
    m.subcategoriesTask.categoryId = categoryId

    m.subcategoriesTask.ObserveField("subcategories", "OnSubcategoriesLoaded")
    m.subcategoriesTask.ObserveField("message", "OnShowMessageInfo")
    m.subcategoriesTask.control = "run"
end sub

sub OnSubcategoriesLoaded()
    subcategories = m.subcategoriesTask.subcategories
    content = CreateObject("roSGNode", "ContentNode")

    for each subcategory in subcategories
        item = content.CreateChild("ContentNode")
        item.title = subcategory.name
        item.description = FormatJson(subcategory)
        item.addFields({
            isSelected: false,
            listHasFocus: false
        })
    end for

    m.subcategoriesList.content = content
    m.spinner.visible = false
    m.subcategoriesList.visible = true
    m.subcategoriesLabel.visible = true
end sub

sub OnSubcategorySelected()
    index = m.subcategoriesList.itemSelected
    subcategory = m.subcategoriesList.content.getChild(index)
    print "Subcategory selected"; subcategory.title

    if m.videoPlayer.payload <> invalid and m.videoPlayer.payload.title = subcategory.title
        m.videoPlayer.videoMode = "fullscreen"
        m.videoPlayer.setFocus(true)
    else
        m.videoPlayer.payload = subcategory
    end if
end sub
