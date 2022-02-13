SVDebt = LibStub("AceAddon-3.0"):NewAddon("SVDebt", "AceEvent-3.0")

function SVDebt:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("SVDebtDB")
    self.RegisterEvent("SPELL_AURA_REMOVED_DOSE", "SpellAuraRemovedDoseEvent")
    self.RegisterEvent("SPELL_AURA_APPLIED", "SpellAuraAppliedEvent")
    self.RegisterEvent("SPELL_AURA_REFRESH", "SpellAuraRefreshEvent")
end

function MyAddon:OnDisable()
    self.UnregisterEvent("SPELL_AURA_REMOVED_DOSE")
    self.UnregisterEvent("SPELL_AURA_APPLIED")
    self.UnregisterEvent("SPELL_AURA_REFRESH")
end

function MyAddon:SpellAuraRemovedDoseEvent(event, ...)
    self.Print(event, args)
end

function MyAddon:SpellAuraAppliedEvent(event, ...)
    self.Print(event, args)
end

function MyAddon:SpellAuraRefreshEvent(event, ...)
    self.Print(event, args)
end
