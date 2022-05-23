class Gauge
{
    vec2 m_pos;
    vec2 m_size;

    vec2 m_resPos;
    vec2 m_center;

    float m_rpm = 0.0f;
    float m_speed = 0.0f;
    int m_gear = 0;

    float m_minRpm = 200.0f; // Minimal RPM to avoid flickering at engine idle
    float m_maxRpm = 11000.0f;

    float startAngle = 110.0f;
    float endAngle = 335.0f;
    float angleTotal = endAngle - startAngle;

    Resources::Font@ m_GearFont;
    Resources::Font@ m_SpeedFont;

    Gauge()
    {
        @m_GearFont = Resources::GetFont("src/Fonts/Oswald-Regular.ttf");
        @m_SpeedFont = Resources::GetFont("src/Fonts/Oswald-Light.ttf");
    }

    void InternalRender(CSceneVehicleVisState@ vis)
    {
        m_rpm = VehicleState::GetRPM(vis);
        m_speed = vis.FrontSpeed * 3.6f;
        m_gear = vis.CurGear;

        if (m_rpm > m_minRpm && m_speed < 0)
            m_gear = -1;

        vec2 screenSize = vec2(Draw::GetWidth(), Draw::GetHeight());
		m_resPos = m_pos * (screenSize - m_size);
        m_center = vec2(m_size.x * 0.5f, m_size.y * 0.5f);
		nvg::Translate(m_resPos.x, m_resPos.y);
		Render();
		nvg::ResetTransform();
    }

    void Render()
    {
        RenderRPM();
        RenderSpeed();
        RenderGear();
    }

    void RenderRPM()
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

    void RenderGear()
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

    void RenderSpeed()
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