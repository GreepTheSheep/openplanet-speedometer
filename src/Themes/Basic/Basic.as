class BasicGauge : Gauge
{

    float startAngle = 110.0f;
    float endAngle = 335.0f;
    float angleTotal = endAngle - startAngle;

    Resources::Font@ m_GearFont;
    Resources::Font@ m_SpeedFont;

    BasicGauge()
    {
        super();
        @m_GearFont = Resources::GetFont("src/Fonts/Oswald-Demi-Bold-Italic.ttf");
        @m_SpeedFont = Resources::GetFont("src/Fonts/Oswald-Light-Italic.ttf");
    }

    void RenderSpeed() override
    {
        vec4 speedColor = vec4(BasicGaugeSettings::BasicGaugeSpeedColor.x, BasicGaugeSettings::BasicGaugeSpeedColor.y, BasicGaugeSettings::BasicGaugeSpeedColor.z, BasicGaugeSettings::BasicGaugeSpeedColorAlpha);
        vec4 speedColorIdle = vec4(BasicGaugeSettings::BasicGaugeSpeedIdleColor.x, BasicGaugeSettings::BasicGaugeSpeedIdleColor.y, BasicGaugeSettings::BasicGaugeSpeedIdleColor.z, BasicGaugeSettings::BasicGaugeSpeedIdleColorAlpha);

        nvg::BeginPath();
        nvg::FontFace(m_SpeedFont);
        nvg::FontSize(m_size.x * 0.2f);
        // remove negative sign
        int speed = Text::ParseInt(Text::Format("%.0f", Math::Abs(m_speed)));
        vec2 margin = vec2(20, 65);
        if (m_speed > -1 && m_speed < 1) {
            nvg::FillColor(speedColorIdle);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "000");
        } else if (speed > 0 && speed < 10) {
            nvg::FillColor(speedColorIdle);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "00");

            vec2 bounds = nvg::TextBounds("00");

            nvg::FillColor(speedColor);
            nvg::Text(m_center.x+margin.x+bounds.x, m_center.y+margin.y, tostring(speed));
        } else if (speed >= 10 && speed < 100) {
            nvg::FillColor(speedColorIdle);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "0");

            vec2 bounds = nvg::TextBounds("0");

            nvg::FillColor(speedColor);
            nvg::Text(m_center.x+margin.x+bounds.x, m_center.y+margin.y, tostring(speed));
        } else {
            nvg::FillColor(speedColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, Text::Format("%03d", speed));
        }
        nvg::ClosePath();
    }

    void RenderRPM() override
    {
        vec4 RPMColor = vec4(BasicGaugeSettings::BasicGaugeRPMColor.x, BasicGaugeSettings::BasicGaugeRPMColor.y, BasicGaugeSettings::BasicGaugeRPMColor.z, BasicGaugeSettings::BasicGaugeRPMColorAlpha);
        vec4 RPMBackground = vec4(BasicGaugeSettings::BasicGaugeRPMBackground.x, BasicGaugeSettings::BasicGaugeRPMBackground.y, BasicGaugeSettings::BasicGaugeRPMBackground.z, BasicGaugeSettings::BasicGaugeRPMBackgroundAlpha);
        vec4 RPMDownshiftColor = vec4(BasicGaugeSettings::BasicGaugeRPMDownshiftColor.x, BasicGaugeSettings::BasicGaugeRPMDownshiftColor.y, BasicGaugeSettings::BasicGaugeRPMDownshiftColor.z, BasicGaugeSettings::BasicGaugeRPMDownshiftColorAlpha);
        vec4 RPMUpshiftColor = vec4(BasicGaugeSettings::BasicGaugeRPMUpshiftColor.x, BasicGaugeSettings::BasicGaugeRPMUpshiftColor.y, BasicGaugeSettings::BasicGaugeRPMUpshiftColor.z, BasicGaugeSettings::BasicGaugeRPMUpshiftColorAlpha);
        // background
        nvg::BeginPath();
        nvg::StrokeColor(RPMBackground);
        nvg::StrokeWidth(m_size.x * BasicGaugeSettings::BasicGaugeRPMArcWidth);
        nvg::Arc(m_center, m_size.x * 0.3, Utils::DegToRad(startAngle), Utils::DegToRad(startAngle + (angleTotal * ((m_maxRpm - m_minRpm) * 0.0001))), nvg::Winding::CW);
        nvg::Stroke();
        nvg::ClosePath();

       if (BasicGaugeSettings::BasicGaugeRPMArc) {
            nvg::BeginPath();
            nvg::StrokeWidth(m_size.x * BasicGaugeSettings::BasicGaugeRPMArcWidth);
            nvg::Arc(m_center, m_size.x * 0.3, Utils::DegToRad(startAngle), Utils::DegToRad(startAngle + (angleTotal * ((m_rpm - m_minRpm) * 0.0001))), nvg::Winding::CW);
            if (m_rpm <= m_minRpm) {
                nvg::StrokeColor(vec4(0,0,0,0));
            } else if (m_rpm <= BasicGaugeSettings::BasicGaugeRPMDownshift && BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift) {
                nvg::StrokeColor(RPMDownshiftColor);
            } else if (m_rpm >= BasicGaugeSettings::BasicGaugeRPMUpshift && BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift) {
                nvg::StrokeColor(RPMUpshiftColor);
            } else {
                nvg::StrokeColor(RPMColor);
            }
            nvg::Stroke();
            nvg::ClosePath();
        }

        if (BasicGaugeSettings::BasicGaugeRPMNeedle) {
            nvg::BeginPath();
            nvg::StrokeWidth(m_size.x * BasicGaugeSettings::BasicGaugeRPMNeedleWidth);
            float length = 0.318;
            float startBase = 4;
            float xs = m_center.x + ((m_size.x*length)/startBase) * Math::Cos(Utils::DegToRad(startAngle + (angleTotal * ((m_rpm - m_minRpm) * 0.0001))));
            float ys = m_center.y + ((m_size.x*length)/startBase) * Math::Sin(Utils::DegToRad(startAngle + (angleTotal * ((m_rpm - m_minRpm) * 0.0001))));
            float xe = m_center.x + (m_size.x*length) * Math::Cos(Utils::DegToRad(startAngle + (angleTotal * ((m_rpm - m_minRpm) * 0.0001))));
            float ye = m_center.y + (m_size.x*length) * Math::Sin(Utils::DegToRad(startAngle + (angleTotal * ((m_rpm - m_minRpm) * 0.0001))));
            nvg::MoveTo(vec2(xs, ys));
            nvg::LineTo(vec2(xe, ye));
            if (m_rpm <= BasicGaugeSettings::BasicGaugeRPMDownshift && BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift) {
                nvg::StrokeColor(RPMDownshiftColor);
            } else if (m_rpm >= BasicGaugeSettings::BasicGaugeRPMUpshift && BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift) {
                nvg::StrokeColor(RPMUpshiftColor);
            } else {
                nvg::StrokeColor(RPMColor);
            }
            nvg::Stroke();
            nvg::ClosePath();
        }
    }

    void RenderGear() override
    {
        vec4 GearColor = vec4(BasicGaugeSettings::BasicGaugeGearColor.x, BasicGaugeSettings::BasicGaugeGearColor.y, BasicGaugeSettings::BasicGaugeGearColor.z, BasicGaugeSettings::BasicGaugeGearColorAlpha);
        vec4 GearUpshiftColor = vec4(BasicGaugeSettings::BasicGaugeGearUpshiftColor.x, BasicGaugeSettings::BasicGaugeGearUpshiftColor.y, BasicGaugeSettings::BasicGaugeGearUpshiftColor.z, BasicGaugeSettings::BasicGaugeGearUpshiftColorAlpha);
        nvg::BeginPath();
        nvg::StrokeWidth(m_size.x * 0.01f);
        nvg::Circle(m_center, m_size.x * 0.08);

        if (m_rpm >= BasicGaugeSettings::BasicGaugeRPMUpshift && BasicGaugeSettings::BasicGaugeGearUpshift) {
            nvg::FillColor(GearUpshiftColor);
            nvg::StrokeColor(GearUpshiftColor);
        } else {
            nvg::FillColor(GearColor);
            nvg::StrokeColor(GearColor);
        }

        // gear text
        nvg::TextAlign(nvg::Align::Center);
        nvg::FontFace(m_GearFont);
        nvg::FontSize(m_size.x * 0.12f);
        string gear = tostring(m_gear);
        if (m_gear == -1) {
            gear = "R";
        }
        nvg::Text(m_center.x-1, m_center.y+11, gear);

        nvg::Stroke();
        nvg::ClosePath();
    }

    void RenderSettingsTab() override
    {
        if (UI::Button("Reset all settings to default")) {
            BasicGaugeSettings::ResetAllToDefault();
        }
        UI::BeginTabBar("Basic Gauge Settings", UI::TabBarFlags::FittingPolicyResizeDown);
        if (UI::BeginTabItem("Speed")) {
            UI::BeginChild("Speed Settings");
            BasicGaugeSettings::BasicGaugeSpeedColor = UI::InputColor3("Speed color", BasicGaugeSettings::BasicGaugeSpeedColor);
            BasicGaugeSettings::BasicGaugeSpeedColorAlpha = UI::SliderFloat("Speed alpha", BasicGaugeSettings::BasicGaugeSpeedColorAlpha,0,1);
            BasicGaugeSettings::BasicGaugeSpeedIdleColor = UI::InputColor3("Idle color (000 speed)", BasicGaugeSettings::BasicGaugeSpeedIdleColor);
            BasicGaugeSettings::BasicGaugeSpeedIdleColorAlpha = UI::SliderFloat("Idle alpha", BasicGaugeSettings::BasicGaugeSpeedIdleColorAlpha,0,1);

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("RPM")) {
            UI::BeginChild("RPM Settings");
            BasicGaugeSettings::BasicGaugeRPMColor = UI::InputColor3("RPM Color", BasicGaugeSettings::BasicGaugeRPMColor);
            BasicGaugeSettings::BasicGaugeRPMColorAlpha = UI::SliderFloat("RPM alpha", BasicGaugeSettings::BasicGaugeRPMColorAlpha,0,1);
            BasicGaugeSettings::BasicGaugeRPMBackground = UI::InputColor3("Background color", BasicGaugeSettings::BasicGaugeRPMBackground);
            BasicGaugeSettings::BasicGaugeRPMBackgroundAlpha = UI::SliderFloat("Background alpha", BasicGaugeSettings::BasicGaugeRPMBackgroundAlpha,0,1);

            BasicGaugeSettings::BasicGaugeRPMNeedle = UI::Checkbox("Needle", BasicGaugeSettings::BasicGaugeRPMNeedle);
            if (BasicGaugeSettings::BasicGaugeRPMNeedle)
                BasicGaugeSettings::BasicGaugeRPMNeedleWidth = UI::SliderFloat("Needle width", BasicGaugeSettings::BasicGaugeRPMNeedleWidth,0,0.1);

            BasicGaugeSettings::BasicGaugeRPMArc = UI::Checkbox("Arc", BasicGaugeSettings::BasicGaugeRPMArc);
            if (BasicGaugeSettings::BasicGaugeRPMArc)
                BasicGaugeSettings::BasicGaugeRPMArcWidth = UI::SliderFloat("Arc width", BasicGaugeSettings::BasicGaugeRPMArcWidth,0,0.1);

            BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift = UI::Checkbox("Downshift/Upshift indicators", BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift);

            if (BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift) {
                UI::TextDisabled("Theres values override the RPM color setting depending on the threshold");
                BasicGaugeSettings::BasicGaugeRPMDownshift = UI::SliderFloat("Downshift threshold", BasicGaugeSettings::BasicGaugeRPMDownshift, 0, 11000);
                BasicGaugeSettings::BasicGaugeRPMDownshiftColor = UI::InputColor3("Downshift color", BasicGaugeSettings::BasicGaugeRPMDownshiftColor);
                BasicGaugeSettings::BasicGaugeRPMDownshiftColorAlpha = UI::SliderFloat("Downshift alpha", BasicGaugeSettings::BasicGaugeRPMDownshiftColorAlpha,0,1);

                BasicGaugeSettings::BasicGaugeRPMUpshift = UI::SliderFloat("Upshift threshold", BasicGaugeSettings::BasicGaugeRPMUpshift, 0, 11000);
                BasicGaugeSettings::BasicGaugeRPMUpshiftColor = UI::InputColor3("Upshift color", BasicGaugeSettings::BasicGaugeRPMUpshiftColor);
                BasicGaugeSettings::BasicGaugeRPMUpshiftColorAlpha = UI::SliderFloat("Upshift alpha", BasicGaugeSettings::BasicGaugeRPMUpshiftColorAlpha,0,1);
            }

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Gears")) {
            UI::BeginChild("Gears Settings");
            BasicGaugeSettings::BasicGaugeGearColor = UI::InputColor3("Gear color", BasicGaugeSettings::BasicGaugeGearColor);
            BasicGaugeSettings::BasicGaugeGearColorAlpha = UI::SliderFloat("Gear alpha", BasicGaugeSettings::BasicGaugeGearColorAlpha,0,1);

            BasicGaugeSettings::BasicGaugeGearUpshift = UI::Checkbox("Upshift indicator", BasicGaugeSettings::BasicGaugeGearUpshift);
            if (BasicGaugeSettings::BasicGaugeGearUpshift) {
                BasicGaugeSettings::BasicGaugeGearUpshiftColor = UI::InputColor3("Upshift color", BasicGaugeSettings::BasicGaugeGearUpshiftColor);
                BasicGaugeSettings::BasicGaugeGearUpshiftColorAlpha = UI::SliderFloat("Upshift alpha", BasicGaugeSettings::BasicGaugeGearUpshiftColorAlpha,0,1);
            }

            UI::EndChild();
            UI::EndTabItem();
        }
        UI::EndTabBar();
    }
}