sub init()
    m.top.functionName = "GetPlaylists"
end sub

sub GetPlaylists()
    config = GetEnvConfig()
    url = config.API_URL + config.ENDPOINTS.IPTV_SERVERS

    urlTransfer = CreateObject("roUrlTransfer")
    urlTransfer.SetUrl(url)
    urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    urlTransfer.AddHeader("apikey", config.API_KEY)
    urlTransfer.AddHeader("Authorization", config.AUTH_TOKEN)

    response = urlTransfer.GetToString()

    if response <> invalid
        json = ParseJson(response)
        if json <> invalid
            m.top.playlists = json
        end if
    end if
end sub