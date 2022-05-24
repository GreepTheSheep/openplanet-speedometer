namespace PluginSettings
{
    [Setting name="Show Dashboard" category="General"]
    bool ShowDashboard = true;

    [Setting name="Hide when not playing" category="General"]
    bool HideWhenNotPlaying = true;

    [Setting name="Locator Mode (move dashboard)" category="General"]
    bool LocatorMode = false;

    enum Themes {
        Basic
    }

    [Setting name="Theme" category="General"]
    Themes Theme = Themes::Basic;

    [Setting name="Position" category="General"]
    vec2 Position = vec2(1.0f, 1.02f);

    [Setting name="Size" category="General"]
    vec2 Size = vec2(250, 200);

    [SettingsTab name="Theme Settings"]
    void RenderThemeSettingsTab()
    {
        g_dashboard.m_gauge.RenderSettingsTab();
    }
}