sub init()
    m.top.SetField("backgroundURI", "")
    m.top.SetField("backgroundColor", "#191a19")
    m.loaderIndicator = m.top.findNode("loaderIndicator")
    m.loaderIndicator.font.size = 48

    InitScreenStack()
    ShowGridScreen()
    RunContentTask()
end sub