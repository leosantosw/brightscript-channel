sub ShowHomeScreen()
    m.HomeScreen = CreateObject("roSGNode", "HomeScreen")
    m.HomeScreen.observeField("categorySelected", "onCategorySelected")
    m.top.appendChild(m.homeScreen)
    ShowScreen(m.HomeScreen)
end sub

sub onCategorySelected()
    if m.homeScreen.categorySelected = "channels"
        category = CreateObject("roSGNode", "ChannelsCategory")
        ShowScreen(category)
    end if

    if m.homeScreen.categorySelected = "playlist"
        playlist = CreateObject("roSGNode", "PlaylistScreen")
        ShowScreen(playlist)
    end if
end sub