function init()
    m.spinner = m.top.getScene().findNode("spinner")

    m.categoriesList = m.top.findNode("categoriesList")
    m.categoriesList.observeField("itemSelected", "OnCategorySelected")
    m.categoriesList.observeField("itemFocused", "OnCategoryFocused")
    m.categoriesList.setFocus(true)

    m.subcategoriesList = m.top.findNode("subcategoriesList")
    m.subcategoriesList.observeField("itemSelected", "OnSubcategorySelected")
    m.subcategoriesList.observeField("itemFocused", "OnSubcategoryFocused")

    m.categoriesLabel = m.top.findNode("categoriesLabel")
    m.subcategoriesLabel = m.top.findNode("subcategoriesLabel")

    m.videoPlayer = createObject("RoSGNode", "VideoPlayer")
    m.top.appendChild(m.videoPlayer)

    LoadCategoriesContent()
end function

sub LoadCategoriesContent()
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

