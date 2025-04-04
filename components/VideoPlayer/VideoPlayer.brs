sub init()
    m.video = m.top.findNode("videoPlayer")
    m.top.observeField("content", "onContentSet")
    m.top.observeField("videoMode", "onVideoModeChanged")
end sub

sub onVideoModeChanged()
    if m.top.videoMode = "pip"
        m.video.width = 600
        m.video.height = 360
        m.video.translation = [660, 120]
        ' m.top.pipMode = true
    else
        m.video.width = 1280
        m.video.height = 720
        m.video.translation = [0, 0]
    end if
end sub

sub onContentSet()
    content = m.top.content
    if content = invalid then return

    desc = ParseJson(content.description)
    if desc = invalid then desc = {}

    streamUrl = buildStreamUrl(desc)

    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = streamUrl
    videoContent.title = content.title
    videoContent.streamformat = "ts"

    videoContent.httpHeaders = {
        "User-Agent": "Roku/DVP-9.40"
    }

    m.video.content = videoContent
    m.video.control = "play"

    ' Inicia no modo PIP por padrão
    m.top.videoMode = "pip"

    m.video.observeField("state", "onVideoStateChanged")
end sub

function buildStreamUrl(desc as object) as string
    if desc.direct_source <> "" then return desc.direct_source
    savedData = loadSavedPlaylist()
    return savedData.server + "/live/" + savedData.username + "/" + savedData.password + "/" + desc.stream_id.toStr() + ".m3u8"
end function

sub onVideoStateChanged()
    state = m.video.state
    print "Estado do vídeo: "; state

    if state = "error"
        showErrorDialog("Erro ao reproduzir o conteúdo")
    end if
end sub

sub showErrorDialog(message as string)
    dialog = createObject("roSGNode", "Dialog")
    dialog.title = "Erro"
    dialog.message = message
    dialog.buttons = ["OK"]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "back"
        if m.top.videoMode = "fullscreen"
            m.top.videoMode = "pip"
            return true
        else
            m.top.closeVideo = true
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

    return false
end function