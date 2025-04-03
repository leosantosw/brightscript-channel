function init()
    m.clock = m.top.findNode("clock")
    m.timer = createObject("roTimespan")

    updateClock()

    m.clockTimer = createObject("roSGNode", "Timer")
    m.clockTimer.repeat = true
    m.clockTimer.duration = 1
    m.clockTimer.control = "start"
    m.clockTimer.observeField("fire", "updateClock")
end function

sub updateClock()
    date = createObject("roDateTime")
    utcHours = date.getHours()
    brasiliaHours = utcHours - 3

    if brasiliaHours < 0 then
        brasiliaHours = brasiliaHours + 24
    else if brasiliaHours >= 24 then
        brasiliaHours = brasiliaHours - 24
    end if

    hours = brasiliaHours.toStr()
    if hours.len() = 1 then hours = "0" + hours

    minutes = date.getMinutes().toStr()
    if minutes.len() = 1 then minutes = "0" + minutes

    m.clock.text = hours + ":" + minutes
end sub
