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

    m.channelsGuideList = m.top.findNode("channelsGuideList")

    m.videoPlayer = createObject("RoSGNode", "VideoPlayer")
    m.top.appendChild(m.videoPlayer)

    LoadCategoriesContent()
end function