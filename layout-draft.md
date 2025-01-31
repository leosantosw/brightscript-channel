 <LayoutGroup
    id="gridContainer"
    layoutDirection="horiz"
    itemSpacings="50"
    vertAlignment="center"
    horizAlignment="center"
>

    <!-- Botão Canais com Logo -->
    <Group id="btnCanais">
        <Rectangle
            width="250"
            height="80"
            color="0xE0E0E0FF"
            cornerRadius="15">
            <LayoutGroup
                layoutDirection="horiz"
                itemSpacings="10"
                translation="[60, 20]">
                <Poster
                    id="logoCanais"
                    uri="pkg:/images/channel.png"
                    width="40"
                    height="40" />
                <Label
                    text="Canais"
                    font="font:MediumBoldSystemFont"
                    horizAlign="left"
                    vertAlign="center"
                    color="0x000000FF"
                    width="150"
                    height="40" />
            </LayoutGroup>
        </Rectangle>
    </Group>

    <!-- Botão Playlist com Logo -->
    <Group id="btnPlaylist">
        <Rectangle
            width="250"
            height="80"
            color="0xE0E0E0FF"
            cornerRadius="8">
            <LayoutGroup
                layoutDirection="horiz"
                itemSpacings="10"
                translation="[60, 20]">
                <Poster
                    id="logoPlaylist"
                    uri="pkg:/images/playlist.png"
                    width="40"
                    height="40" />
                <Label
                    text="Playlist"
                    font="font:MediumBoldSystemFont"
                    horizAlign="left"
                    vertAlign="center"
                    color="0x000000FF"
                    width="150"
                    height="40" />
            </LayoutGroup>
        </Rectangle>
    </Group>
</LayoutGroup>