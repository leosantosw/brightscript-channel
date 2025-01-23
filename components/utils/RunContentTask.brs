sub RunContentTask()
    m.contentTask = CreateObject("roSGNode", "MainLoaderTask")
    m.contentTask.ObserveField("content", "OnMainContentLoaded")
    m.contentTask.control = "run"
    m.loaderIndicator.visible = true
end sub 

sub OnMainContentLoaded()
    m.GridScreen.setFocus(true)
    m.loaderIndicator.visible = false
    m.GridScreen.content = m.contentTask.content
end sub