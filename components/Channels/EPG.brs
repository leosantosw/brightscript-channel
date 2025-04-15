sub LoadEpg(streamId as integer)
    m.epgTask = CreateObject("roSGNode", "EPGTask")
    m.epgTask.liveStreamId = streamId
    m.epgTask.ObserveField("epg", "OnEPGLoaded")
    m.epgTask.control = "run"
end sub

sub OnEPGLoaded()
    epgs = m.epgTask.epg
    content = CreateObject("roSGNode", "ContentNode")

    for each epg in epgs
        item = content.CreateChild("ContentNode")
        item.addFields({
            title: epg.title,
            description: epg.description,
        })
    end for

    m.channelsGuideList.content = content
end sub

