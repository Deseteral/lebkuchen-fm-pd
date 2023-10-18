import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/nineslice"
import "CoreLibs/crank"

local pd <const> = playdate
local gfx <const> = playdate.graphics

local gridview = pd.ui.gridview.new(0, 32)

local xsounds = {
    { name = "Loading sounds..." },
}

gridview:setNumberOfRows(#xsounds)
gridview:setCellPadding(2, 2, 2, 2)

gridview:setContentInset(5, 5, 5, 5)

local gridviewSprite = gfx.sprite.new()
gridviewSprite:setCenter(0, 0)
gridviewSprite:moveTo(0, 0)
gridviewSprite:add()

function gridview:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
        gfx.fillRoundRect(x, y, width, height, 4)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    else
        gfx.setImageDrawMode(gfx.kDrawModeCopy)
    end
    local fontHeight = gfx.getSystemFont():getHeight()
    gfx.drawTextInRect(xsounds[row].name, x, y + (height / 2 - fontHeight / 2) + 2, width, height,
        nil,
        nil,
        kTextAlignment.center)
end

function pd.update()
    if pd.buttonJustPressed(pd.kButtonA) then
        local s, r, c = gridview:getSelection()
        print("/fm x " .. xsounds[r].name)
    end

    if pd.buttonJustPressed(pd.kButtonUp) then
        gridview:selectPreviousRow(true)
    elseif pd.buttonJustPressed(pd.kButtonDown) then
        gridview:selectNextRow(true)
    end

    local crankTicks = pd.getCrankTicks(4)
    if crankTicks == 1 then
        gridview:selectNextRow(true)
    elseif crankTicks == -1 then
        gridview:selectPreviousRow(true)
    end

    if gridview.needsDisplay then
        local gridviewImage = gfx.image.new(pd.display.getWidth(), pd.display.getHeight())
        gfx.pushContext(gridviewImage)
        gridview:drawInRect(0, 0, pd.display.getWidth(), pd.display.getHeight())
        gfx.popContext()
        gridviewSprite:setImage(gridviewImage)
    end

    gfx.sprite.update()
    pd.timer.updateTimers()
end

function setXSoundList(list)
    gridview:setSelectedRow(1)
    xsounds = list
    gridview:setNumberOfRows(#xsounds)
end
