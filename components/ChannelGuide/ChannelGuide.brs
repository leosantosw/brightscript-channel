sub init()
    m.labelText = m.top.findNode("labelText")
end sub

sub updateTitle()
    content = m.top.itemContent

    print "content: " ; content
    print "content.title: "; content.title
    print "content.title: "; content.startTime
    if content <> invalid and content.title <> invalid then
        m.labelText.text = content.title
    end if
end sub