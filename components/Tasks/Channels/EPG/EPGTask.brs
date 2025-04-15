sub Init()
    m.top.functionName = "GetEPG"
end sub

sub GetEPG()
    savedData = loadSavedPlaylist()
    server = savedData.server
    username = savedData.username
    password = savedData.password
    liveStreamId = m.top.liveStreamId.toStr()

    baseUrl = server + "/player_api.php?username=" + username + "&password=" + password + "&action=get_short_epg&stream_id=" + liveStreamId
    print "Base URL: "; baseUrl
    request = CreateObject("roUrlTransfer")
    request.SetUrl(baseUrl)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")

    response = request.GetToString()

    if response = invalid then
        return
    end if

    if response = "" then
        m.top.epg = "EPG não disponível"
        return
    end if

    json = ParseJson(response)
    if json = invalid then
        m.top.epg = "Falha ao carregar EPG"
        return
    end if

    epgs = CreateObject("roArray", 0, true)
    for each epg in json.epg_listings
        print "EPG: "; epg
        startTime = GetDurationStringStandard(Val(epg.start_timestamp))
        stopTime = GetDurationStringStandard(Val(epg.stop_timestamp))
        epgs.Push({
            title: startTime + " ~ " + stopTime + " | " + DecodeBase64(epg.title),
            description: DecodeBase64(epg.description),
        })
    end for

    m.top.epg = epgs
end sub

function DecodeBase64(base64String as string) as string
    if base64String = "" then return ""

    ba = CreateObject("roByteArray")

    ba.FromBase64String(base64String)
    result = ba.ToAsciiString()

    ' if not IsAsciiPrintable(result)
    '     return base64String
    ' end if

    return result
end function

' function IsAsciiPrintable(s as string) as boolean
'     for i = 0 to len(s) - 1
'         code = asc(mid(s, i, 1))
'         if code < 32 or code > 126 then
'             return false
'         end if
'     end for
'     return true
' end function

function GetDurationStringStandard(TotalSeconds = 0 as integer) as string
    datetime = CreateObject("roDateTime")
    datetime.FromSeconds(TotalSeconds)
    hours = datetime.GetHours().ToStr()
    minutes = datetime.GetMinutes().ToStr()

    if Len(hours) = 1 then
        hours = "0" + hours
    end if

    if Len(minutes) = 1 then
        minutes = "0" + minutes
    end if

    if hours <> "00" then
        return hours + ":" + minutes
    else
        return minutes
    end if
end function