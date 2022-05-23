class Dashboard
{
    Gauge@ m_gauge;

    Dashboard()
    {
        @m_gauge = Gauge();
    }

    void Render()
    {
        if (!PluginSettings::ShowDashboard) return;

        auto app = GetApp();

        if (PluginSettings::HideWhenNotPlaying) {
            if (app.CurrentPlayground !is null && (app.CurrentPlayground.UIConfigs.Length > 0)) {
                if (app.CurrentPlayground.UIConfigs[0].UISequence == CGamePlaygroundUIConfig::EUISequence::Intro) {
                    return;
                }
            }
        }

        auto visState = VehicleState::ViewingPlayerState();
        if (visState is null) return;

        m_gauge.m_pos = PluginSettings::Position;
        m_gauge.m_size = PluginSettings::Size;

        m_gauge.InternalRender(visState);
    }
}