function init()
    m.top.backgroundUri = ""
    m.top.backgroundColor = "#030712"

    m.loadingIndicator = m.top.findNode("spinner")
    InitScreenStack()
    ShowHomeScreen()
end function

function OnkeyEvent(key as string, press as boolean) as boolean
    result = false
    if press
        if key = "back"
            numberOfScreens = m.screenStack.Count()
            if numberOfScreens > 1
                CloseScreen(invalid)
                result = true
            end if
        end if
    end if
    return result
end function
