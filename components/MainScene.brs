function init()
    m.top.backgroundUri = ""
    m.top.backgroundColor = "#0E1420"
    
    m.loadingIndicator = m.top.findNode("spinner") 
    InitScreenStack()
    ShowHomeScreen()
end function

function OnkeyEvent(key as String, press as Boolean) as Boolean
  result = false
  if press
      ' handle "back" key press
      if key = "back"
          numberOfScreens = m.screenStack.Count()
          print "NumberOfScreens: "; numberOfScreens
          if numberOfScreens > 1
              CloseScreen(invalid)
              result = true
          end if
      end if
  end if
  return result
end function
