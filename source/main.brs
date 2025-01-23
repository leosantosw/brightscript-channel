sub main ()
    showChannel()
end sub

sub showChannel()
    screen = CreateObject("roSGScreen")
    
    m.port = createObject("roMessagePort")
    screen.setMessagePort(m.port)
    
    scene = screen.CreateScene("MainScene")
    screen.show()
    
    scene.observeField("appExit", m.port)

    while true
        msg = wait(0, m.port)
        msgType = type(msg)
        print msgType

        if msgType = "roSGScreenEvent"
            print msg.GetMessage()
            if msg.isScreenClosed() then return
        end if
        
      end while
end sub