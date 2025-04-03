function init()
    m.spinner = m.top.getScene().findNode("spinner")

    m.categoriesList = m.top.findNode("categoriesList")
    m.categoriesList.observeField("itemSelected", "OnItemSelected")
    m.categoriesList.setFocus(true)

    m.subcategoriesList = m.top.findNode("subcategoriesList")
    m.subcategoriesList.visible = false

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

sub OnItemSelected()
    index = m.categoriesList.itemSelected
    if index >= 0 and index < m.categoriesList.content.getChildCount() then
        selectedItem = m.categoriesList.content.getChild(index)
        categoryData = ParseJson(selectedItem.description)

        if categoryData <> invalid and categoryData.category_id <> invalid then
            loadSubcategories(categoryData.category_id)
        else
            print "Dados da categoria inválidos"
        end if
    end if
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
        ' item.description = FormatJson(subcategory)
    end for

    m.subcategoriesList.content = content
    m.subcategoriesList.visible = true
    m.subcategoriesLabel.visible = true
end sub

' function onKeyEvent(key as string, press as boolean) as boolean
'     if press then
'         if key = "back"
'             return false
'         else if key = "OK"
'             category = m.categoriesList.content.getChild(m.categoriesList.itemSelected)
'             print "Selected category: "; category.title
'             return true
'         end if
'     end if
'     return true
' end function