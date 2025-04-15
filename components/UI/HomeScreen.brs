sub ShowHomeScreen()
    m.HomeScreen = CreateObject("roSGNode", "HomeScreen")
    m.HomeScreen.observeField("categorySelected", "onCategorySelected")
    ShowScreen(m.HomeScreen)

    ' category = CreateObject("roSGNode", "ChannelsCategories")
    ' ShowScreen(category)
end sub

sub ShowPlaylistScreen()
    m.Playlist = CreateObject("roSGNode", "PlaylistScreen")
    m.playlist.ObserveField("navigateToHome", "onNavigateToHome")
    ShowScreen(m.Playlist)
end sub

sub onCategorySelected()
    if m.homeScreen.categorySelected = "channels"
        category = CreateObject("roSGNode", "ChannelsScreen")
        ShowScreen(category)
    end if

    if m.homeScreen.categorySelected = "playlist"
        ShowPlaylistScreen()
    end if
end sub

sub onNavigateToHome()
    CloseScreen(invalid)
end sub