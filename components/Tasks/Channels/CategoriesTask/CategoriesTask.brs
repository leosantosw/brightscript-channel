sub init()
    m.top.functionName = "GetCategories"
end sub

sub GetCategories()
    savedData = loadSavedPlaylist()

    if savedData = invalid or savedData.server = invalid then
        m.top.message = "Você ainda não configurou nenhuma lista."
        return
    end if

    server = savedData.server
    username = savedData.username
    password = savedData.password
    baseUrl = server + "/player_api.php?username=" + username + "&password=" + password + "&action=get_live_categories"

    request = CreateObject("roUrlTransfer")
    request.SetUrl(baseUrl)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("Content-Type", "application/json")

    response = request.GetToString()

    if response = invalid or response = "" then
        m.top.message = "Falha ao carregar lista"
        return
    end if

    json = ParseJson(response)
    if json = invalid then
        m.top.message = "Dados da lista inválidos"
        return
    end if
    m.top.categories = json
end sub
