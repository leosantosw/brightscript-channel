sub init()
    m.video = m.top.findNode("videoPlayer")
    m.top.observeField("content", "onContentSet")
end sub

sub onContentSet()
    content = m.top.content
    if content = invalid then return

    desc = ParseJson(content.description)
    if desc = invalid then desc = {}

    streamUrl = buildStreamUrl(desc)
    print "streamUrl: "; streamUrl

    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = streamUrl
    videoContent.title = content.title
    videoContent.streamformat = "hls" ' ou "mp4", "ts" conforme necessário

    videoContent.httpHeaders = {
        "User-Agent": "Roku/DVP-9.40"
    }

    ' Inicia a reprodução
    m.video.content = videoContent
    m.video.control = "play"
    m.video.setFocus(true)

    ' Observa eventos do player
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
        return false
    end if

    return false
end function