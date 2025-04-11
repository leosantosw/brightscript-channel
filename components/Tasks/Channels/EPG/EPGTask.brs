sub Init()
    m.top.functionName = "GetEPG"
end sub

sub GetEPG()
    savedData = loadSavedPlaylist()
    server = savedData.server
    username = savedData.username
    password = savedData.password
    categoryId = m.top.categoryId

    baseUrl = server + "/get.php?username=" + username + "&password=" + password + "&action=get_live_streams&category_id=" + categoryId

    request = CreateObject("roUrlTransfer")
    request.SetUrl(baseUrl)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")

    response = request.GetToString()

    if response = invalid or response = "" then
        m.top.message = "Falha ao carregar canais"
        return
    end if

    json = ParseJson(response)
    if json = invalid then
        m.top.message = "Falha ao carregar canais"
        return
    end if
    m.top.subcategories = json
end sub