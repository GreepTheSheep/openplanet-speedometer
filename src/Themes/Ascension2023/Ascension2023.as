class Ascension2023Gauge : Gauge
{
    nvg::Font m_SpeedFont;

    Ascension2023Gauge()
    {
        super();
        m_SpeedFont = nvg::LoadFont("src/Fonts/Venera-900.ttf");
    }

    void RenderBackground() override
    {
        nvg::BeginPath();

        nvg::RoundedRect(vec2(m_center.x-130, m_center.y-20), vec2(m_size.x-125, m_size.y-280), 10);
        nvg::StrokeColor(Ascension2023GaugeSettings::Ascension2023GaugeBackgroundStrokeColor);
        nvg::Stroke();

        nvg::ClosePath();
    }

    void RenderSpeed() override
    {
        nvg::BeginPath();
        nvg::FontFace(m_SpeedFont);
        nvg::FontSize(m_size.x * 0.17f);
        int speed = Text::ParseInt(Text::Format("%.0f", Math::Abs(m_speed)));
        vec2 margin = vec2(-100, m_size.y * 0.10f);
        nvg::FillColor(Ascension2023GaugeSettings::Ascension2023GaugeSpeedColor);
        nvg::Text(m_center.x+margin.x, m_center.y+margin.y, Text::Format("%03d", speed));
        nvg::ClosePath();
    }

    void RenderGear() override
    {
        nvg::BeginPath();

        nvg::RoundedRect(vec2(m_center.x-145, m_center.y-5), vec2(m_size.x-320, m_size.y-310), 10);
        nvg::FillColor(Ascension2023GaugeSettings::Ascension2023GaugeGearBackgroundColor);
        nvg::Fill();

        nvg::FontFace(m_SpeedFont);
        nvg::FontSize(m_size.x * 0.07f);
        int speed = Text::ParseInt(Text::Format("%.0f", Math::Abs(m_speed)));
        vec2 margin = vec2(-100, m_size.y * 0.10f);
        nvg::FillColor(Ascension2023GaugeSettings::Ascension2023GaugeGearColor);
        string gear = tostring(m_gear);
        if (m_gear == -1) gear = "R";
        if (m_gear == 1) nvg::Text(m_center.x-135, m_center.y+23, gear);
        else nvg::Text(m_center.x-142, m_center.y+23, gear);
        nvg::ClosePath();
    }

    void RenderSettingsTab() override
    {
        if (UI::Button("Reset to default")) {
            Ascension2023GaugeSettings::ResetAllToDefault();
        }

        Ascension2023GaugeSettings::Ascension2023GaugeBackgroundStrokeColor = UI::InputColor4("Rectangle color", Ascension2023GaugeSettings::Ascension2023GaugeBackgroundStrokeColor);
        Ascension2023GaugeSettings::Ascension2023GaugeSpeedColor = UI::InputColor4("Speed color", Ascension2023GaugeSettings::Ascension2023GaugeSpeedColor);
        Ascension2023GaugeSettings::Ascension2023GaugeGearBackgroundColor = UI::InputColor4("Gear background color", Ascension2023GaugeSettings::Ascension2023GaugeGearBackgroundColor);
        Ascension2023GaugeSettings::Ascension2023GaugeGearColor = UI::InputColor4("Gear text color", Ascension2023GaugeSettings::Ascension2023GaugeGearColor);
    }
}