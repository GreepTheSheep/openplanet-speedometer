class ArcGauge : Gauge
{
    void RenderRPM() override
    {
        // background
        nvg::BeginPath();
        nvg::StrokeColor(PluginSettings::RPMBackground);
        nvg::StrokeWidth(m_size.x * 0.04f);
        nvg::Arc(m_center, m_size.x * 0.3, Utils::DegToRad(startAngle), Utils::DegToRad(startAngle + (angleTotal * ((m_maxRpm - m_minRpm) * 0.0001))), nvg::Winding::CW);
        nvg::Stroke();
        nvg::ClosePath();

        // foreground
        nvg::BeginPath();
        nvg::StrokeWidth(m_size.x * 0.04f);
        nvg::Arc(m_center, m_size.x * 0.3, Utils::DegToRad(startAngle), Utils::DegToRad(startAngle + (angleTotal * ((m_rpm - m_minRpm) * 0.0001))), nvg::Winding::CW);
        if (m_rpm <= m_minRpm) {
            nvg::StrokeColor(vec4(0,0,0,0));
        } else if (m_rpm <= PluginSettings::RPMDownshift && PluginSettings::RPMDownshiftUpshift) {
            nvg::StrokeColor(PluginSettings::RPMDownshiftColor);
        } else if (m_rpm >= PluginSettings::RPMUpshift && PluginSettings::RPMDownshiftUpshift) {
            nvg::StrokeColor(PluginSettings::RPMUpshiftColor);
        } else {
            nvg::StrokeColor(PluginSettings::RPMColor);
        }
        nvg::Stroke();
        nvg::ClosePath();
    }

    void RenderGear() override
    {
        nvg::BeginPath();
        nvg::StrokeWidth(m_size.x * 0.01f);
        nvg::Circle(m_center, m_size.x * 0.08);

        if (m_rpm >= PluginSettings::RPMUpshift && PluginSettings::GearUpshift) {
            nvg::FillColor(PluginSettings::GearUpshiftColor);
            nvg::StrokeColor(PluginSettings::GearUpshiftColor);
        } else {
            nvg::FillColor(PluginSettings::GearColor);
            nvg::StrokeColor(PluginSettings::GearColor);
        }

        // gear text
        nvg::TextAlign(nvg::Align::Center);
        nvg::FontFace(m_GearFont);
        nvg::FontSize(m_size.x * 0.1f);
        string gear = tostring(m_gear);
        if (m_gear == -1) {
            gear = "R";
        }
        nvg::Text(m_center.x, m_center.y+9, gear);

        nvg::Stroke();
        nvg::ClosePath();
    }

    void RenderSpeed() override
    {
        nvg::BeginPath();
        nvg::FontFace(m_SpeedFont);
        nvg::FontSize(m_size.x * 0.2f);
        // remove negative sign
        int speed = Text::ParseInt(Text::Format("%.0f", Math::Abs(m_speed)));
        vec2 margin = vec2(20, 60);
        if (m_speed > -1 && m_speed < 1) {
            nvg::FillColor(PluginSettings::SpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "000");
        } else if (speed > 0 && speed < 10) {
            nvg::FillColor(PluginSettings::SpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "00");

            vec2 bounds = nvg::TextBounds("00");

            nvg::FillColor(PluginSettings::SpeedColor);
            nvg::Text(m_center.x+margin.x+bounds.x, m_center.y+margin.y, tostring(speed));
        } else if (speed >= 10 && speed < 100) {
            nvg::FillColor(PluginSettings::SpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "0");

            vec2 bounds = nvg::TextBounds("0");

            nvg::FillColor(PluginSettings::SpeedColor);
            nvg::Text(m_center.x+margin.x+bounds.x, m_center.y+margin.y, tostring(speed));
        } else {
            nvg::FillColor(PluginSettings::SpeedColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, Text::Format("%03d", speed));
        }
        nvg::ClosePath();
    }
}