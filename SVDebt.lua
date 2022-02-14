SVDebt = LibStub("AceAddon-3.0"):NewAddon("SVDebt", "AceEvent-3.0", "AceConsole-3.0")
AceGUI = LibStub("AceGUI-3.0")

local DEFAULTS = {}
local SV_SPELL_ID = 17800

function SVDebt:OnInitialize()
    print("SVDebt loaded, use /svdebt to view statistics")

    SVDebt:RegisterChatCommand("svdebt", "OpenStats")

    self.db = LibStub("AceDB-3.0"):New("SVDebtDB", DEFAULTS, true)
    SVDebt:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CombatLogEvent")

    if not self.db.realm.application then
        self.db.realm.application = {}
    end

    if not self.db.realm.consumption then
        self.db.realm.consumption = {}
    end
end

function SVDebt:OnDisable()
    SVDebt:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function SVDebt:CombatLogEvent()
    local timestamp, event, hideCaster, srcGUID, srcName, srcFlags, sourceRaidFlags, dstGUID, dstName, dstFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16 = CombatLogGetCurrentEventInfo()

    if event == "SPELL_AURA_APPLIED" and arg12 == SV_SPELL_ID then
        if not self.db.realm.application[srcName] then
            self.db.realm.application[srcName] = 0
        end

        self.db.realm.application[srcName] = self.db.realm.application[srcName] + 1

    elseif event == "SPELL_AURA_APPLIED_DOSE" and arg12 == SV_SPELL_ID then
        if not self.db.realm.application[srcName] then
            self.db.realm.application[srcName] = 0
        end

        self.db.realm.application[srcName] = self.db.realm.application[srcName] + 1

    -- elseif event == "SPELL_AURA_REFRESH" and arg12 == SV_SPELL_ID then
    --     print(".")

    elseif event == "SPELL_AURA_REMOVED_DOSE" and arg12 == SV_SPELL_ID then
        if not self.db.realm.consumption[srcName] then
            self.db.realm.consumption[srcName] = 0
        end

        self.db.realm.consumption[srcName] = self.db.realm.consumption[srcName] + 1

    -- elseif event == "SPELL_AURA_REMOVED" and arg12 == SV_SPELL_ID then
    --     print(".")

    end
end

function SVDebt:OpenStats()
    local frame = AceGUI:Create("Frame")
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetTitle("SVDebt")
    frame:SetLayout("Flow")
    frame:SetStatusText("Shadow Vulnerability Debt statistics.")
end
