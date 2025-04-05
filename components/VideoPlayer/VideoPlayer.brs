sub init()
    m.video = m.top.findNode("videoPlayer")
    m.video.visible = false
    m.top.observeField("payload", "onContentSet")
    m.top.observeField("videoMode", "onVideoModeChanged")
    m.lastStreamUrl = ""
end sub

sub onContentSet()
    payload = m.top.payload
    if payload = invalid then return

    ' if m.video.payload = payload then
    '     m.top.videoMode = "fullscreen"
    '     print "Video already set"
    '     return
    ' end if

    m.video.visible = true

    desc = ParseJson(payload.description)
    if desc = invalid then desc = {}

    streamUrl = buildStreamUrl(desc)
    print "Stream URL: "; streamUrl
    print "Last Stream URL: "; m.lastStreamUrl

    m.lastStreamUrl = streamUrl

    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = streamUrl
    videoContent.title = payload.title
    videoContent.streamformat = "ts"

    videoContent.httpHeaders = {
        "User-Agent": "Roku/DVP-9.40"
    }

    m.video.content = videoContent
    m.video.control = "play"
    m.top.videoMode = "pip"
end sub

sub onVideoModeChanged()
    if m.top.videoMode = "pip"
        m.video.width = 600
        m.video.height = 360
        m.video.translation = [660, 120]
    else
        m.video.width = 1280
        m.video.height = 720
        m.video.translation = [0, 0]
    end if
end sub


function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "back"
        if m.top.videoMode = "fullscreen"
            m.top.videoMode = "pip"
            m.top.getScene().findNode("subcategoriesList").setFocus(true)
            return true
        else
            m.video.control = "stop"
            m.video.visible = false
            m.top.getScene().findNode("subcategoriesList").setFocus(true)
            return true
        end if
    else if key = "OK"
        if m.top.videoMode = "fullscreen"
            m.top.videoMode = "pip"
        else
            m.top.videoMode = "fullscreen"
        end if
        return true
    end if

    return true
end function

' m.video.observeField("state", "onVideoStateChanged")
' sub onVideoStateChanged()
'     state = m.video.state

'     if state = "error"
'         showErrorDialog("Erro ao reproduzir o conteúdo")
'     end if
' end sub


sub showErrorDialog(message as string)
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = "Erro"
    dialog.message = message
    dialog.buttons = ["OK"]
end sub

function buildStreamUrl(desc as object) as string
    if desc.direct_source <> "" then return desc.direct_source
    savedData = loadSavedPlaylist()
    return savedData.server + "/live/" + savedData.username + "/" + savedData.password + "/" + desc.stream_id.toStr() + ".ts"
end function