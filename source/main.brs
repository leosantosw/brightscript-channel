sub main()
    showChannel()
end sub

sub showChannel()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    
    scene = screen.CreateScene("MainScene")
    screen.show()
    
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
        
        if scene.exit = true then
            screen.close()
        end if
    end while
end sub