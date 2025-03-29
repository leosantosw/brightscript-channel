sub init()
  m.busyspinner = m.top.findNode("spinner")
  m.busyspinner.poster.uri = "pkg:/images/spinner.png"
  m.busyspinner.poster.observeField("loadStatus", "ShowSpinner")
end sub

sub ShowSpinner()
  if(m.busyspinner.poster.loadStatus = "ready")
    centerx = (1280 - m.busyspinner.poster.bitmapWidth) / 2
    centery = (720 - m.busyspinner.poster.bitmapHeight) / 2
    m.busyspinner.translation = [centerx, centery]
  end if
end sub