Dashboard@ g_dashboard;

void Main()
{
    @g_dashboard = Dashboard();
}

void Render()
{
    g_dashboard.Render();
}

void RenderInterface()
{
    if (PluginSettings::LocatorMode) {
        Locator::Render("Speedometer", PluginSettings::Position, PluginSettings::Size);
        PluginSettings::Position = Locator::GetPos();
        PluginSettings::Size = Locator::GetSize();
    }
}

void RenderMenu()
{
    if(UI::MenuItem("\\$fa0" + Icons::Kenney::ButtonCircle + " \\$zSpeedometer", "", PluginSettings::ShowSpeedometer))
        PluginSettings::ShowSpeedometer = !PluginSettings::ShowSpeedometer;
}

void OnSettingsChanged()
{
    g_dashboard.UpdateGaugeTheme();
}