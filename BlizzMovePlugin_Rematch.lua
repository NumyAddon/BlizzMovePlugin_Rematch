local name, Plugin = ...;

do
    local frame = CreateFrame('Frame');
    frame:HookScript('OnEvent', function(_, _, addonName) Plugin:ADDON_LOADED(addonName); end);
    frame:RegisterEvent('ADDON_LOADED');
end

function Plugin:ADDON_LOADED(addonName)
    if addonName ~= name then return; end
    local compatible = false;
    if(BlizzMoveAPI and BlizzMoveAPI.GetVersion and BlizzMoveAPI.RegisterAddOnFrames) then
        local _, _, _, _, versionInt = BlizzMoveAPI:GetVersion();
        if (versionInt == nil or versionInt >= 30200) then
            compatible = true;
        end
    end

    if(not compatible) then
        print(name .. ' is not compatible with the current version of BlizzMove, please update.');
        return;
    end

    local frameTable = {
        ['Blizzard_Collections'] =
        {
            ['CollectionsJournal'] =
            {
                MinVersion = 20000,
                SubFrames =
                {
                    ['RematchJournal'] =
                    {
                        MinVersion = 20000,
                        SubFrames =
                        {
                            ['RematchTeamPanel.List.ScrollFrame.CaptureButton'] =
                            {
                                MinVersion = 20000,
                            },
                        },
                    },
                },
            },
        },
    };
    BlizzMoveAPI:RegisterAddOnFrames(frameTable);
end
