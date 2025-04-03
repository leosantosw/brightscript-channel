function init()
    m.spinner = m.top.getScene().findNode("spinner")

    m.categoriesList = m.top.findNode("categoriesList")
    m.categoriesList.observeField("itemSelected", "OnCategorySelected")
    m.categoriesList.setFocus(true)

    m.subcategoriesList = m.top.findNode("subcategoriesList")
    m.subcategoriesList.observeField("itemSelected", "OnSubcategorySelected")

    m.categoriesLabel = m.top.findNode("categoriesLabel")
    m.subcategoriesLabel = m.top.findNode("subcategoriesLabel")

    loadContent()
end function

sub loadContent()
    m.spinner.visible = true
    m.contentTask = CreateObject("roSGNode", "ChannelsCategoriesTask")
    m.contentTask.ObserveField("categories", "OnCategoriesLoaded")
    m.contentTask.ObserveField("message", "OnShowMessageInfo")
    m.contentTask.control = "run"
end sub

sub OnCategoriesLoaded()
    m.spinner.visible = false
    categories = m.contentTask.categories
    content = CreateObject("roSGNode", "ContentNode")

    for each category in categories
        item = content.CreateChild("ContentNode")
        item.title = category.category_name
        item.description = FormatJson(category)
    end for

    m.categoriesList.content = content
end sub

sub OnShowMessageInfo()
    m.spinner.visible = false
    message = m.contentTask.message
    m.categoriesLabel.text = message
    m.categoriesLabel.width = "1280"
end sub

sub OnCategorySelected()
    index = m.categoriesList.itemSelected
    selectedItem = m.categoriesList.content.getChild(index)
    categoryData = ParseJson(selectedItem.description)
    loadSubcategories(categoryData.category_id)
end sub

sub OnSubcategorySelected()
    index = m.subcategoriesList.itemSelected
    subcategory = m.subcategoriesList.content.getChild(index)
    videoPlayer = createObject("RoSGNode", "VideoPlayer")
    videoPlayer.content = subcategory
    m.top.appendChild(videoPlayer)
    videoPlayer.setFocus(true)
end sub

sub loadSubcategories(categoryId as string)
    m.subcategoriesList.visible = false
    m.spinner.visible = true
    m.subcategoriesTask = CreateObject("roSGNode", "SubcategoriesTask")
    m.subcategoriesTask.categoryId = categoryId

    m.subcategoriesTask.ObserveField("subcategories", "OnSubcategoriesLoaded")
    m.subcategoriesTask.ObserveField("message", "OnShowMessageInfo")
    m.subcategoriesTask.control = "run"
end sub

sub OnSubcategoriesLoaded()
    m.spinner.visible = false
    subcategories = m.subcategoriesTask.subcategories
    content = CreateObject("roSGNode", "ContentNode")

    for each subcategory in subcategories
        item = content.CreateChild("ContentNode")
        item.title = subcategory.name
        item.description = FormatJson(subcategory)
    end for

    m.subcategoriesList.content = content
    m.subcategoriesList.visible = true
    m.subcategoriesLabel.visible = true
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press then
        if key = "right"
            if m.subcategoriesList.content <> invalid and m.subcategoriesList.content.getChildCount() > 0
                m.categoriesList.setFocus(false)
                m.subcategoriesList.setFocus(true)
                handled = true
            end if
        else if key = "left"
            if m.subcategoriesList.hasFocus()
                m.subcategoriesList.setFocus(false)
                m.categoriesList.setFocus(true)
                handled = true
            end if
        end if
    end if
    return handled
end function
