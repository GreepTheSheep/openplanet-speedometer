class BasicDigitalGauge : Gauge
{
    nvg::Font m_GearFont;
    nvg::Font m_SpeedFont;

    BasicDigitalGauge()
    {
        super();
        m_GearFont = nvg::LoadFont("src/Fonts/Oswald-Demi-Bold-Italic.ttf");
        m_SpeedFont = nvg::LoadFont("src/Fonts/Oswald-Light-Italic.ttf");
    }

    void RenderSpeed() override
    {
        nvg::BeginPath();
        nvg::FontFace(m_SpeedFont);
        nvg::FontSize(m_size.x * 0.28f);
        // remove negative sign
        int speed = Text::ParseInt(Text::Format("%.0f", Math::Abs(m_speed)));
        vec2 margin = vec2(-20, 40);
        if (m_speed > -1 && m_speed < 1) {
            nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "000");
        } else if (speed > 0 && speed < 10) {
            nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "00");

            vec2 bounds = nvg::TextBounds("00");

            nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor);
            nvg::Text(m_center.x+margin.x+bounds.x, m_center.y+margin.y, tostring(speed));
        } else if (speed >= 10 && speed < 100) {
            nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "0");

            vec2 bounds = nvg::TextBounds("0");

            nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor);
            nvg::Text(m_center.x+margin.x+bounds.x, m_center.y+margin.y, tostring(speed));
        } else {
            nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, Text::Format("%03d", speed));
        }
        nvg::ClosePath();
    }

    void RenderRPM() override
    {
        const float blockPadding = 6.0f;
        float blockSpace = blockPadding + BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBlockSpace - 4;
        int numDots = int(Math::Floor(m_size.x / blockSpace) - 12 - BasicDigitalGaugeSettings::BasicDigitalGaugeRPMSize);

        for (int i = 0; i < numDots; i++) {
            float scaledRpm = i / float(numDots) * m_maxRpm;

            nvg::BeginPath();
            nvg::RoundedRect(m_center.x + i * blockSpace + blockPadding - BasicDigitalGaugeSettings::BasicDigitalGaugeRPMHorizontalPos, m_center.y + blockPadding + BasicDigitalGaugeSettings::BasicDigitalGaugeRPMVerticalPos, 4.5, 30, 4);
            if (m_rpm > m_minRpm && m_rpm >= scaledRpm) {
                if (m_rpm <= BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshift && BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift) {
                    nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColor);
                } else if (m_rpm >= BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshift && BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift) {
                    nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColor);
                } else {
                    nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColor);
                }
            } else {
                nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackground);
            }
            nvg::Fill();
        }
    }

    void RenderGear() override
    {
        vec2 margin = vec2(-55, 20);
        nvg::BeginPath();
        nvg::StrokeWidth(m_size.x * 0.01f);
        nvg::Circle(m_center+margin, m_size.x * 0.08);

        if (m_rpm >= BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshift && BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshift) {
            nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor);
            nvg::StrokeColor(BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor);
        } else {
            nvg::FillColor(BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor);
            nvg::StrokeColor(BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor);
        }

        // gear text
        nvg::TextAlign(nvg::Align::Center);
        nvg::FontFace(m_GearFont);
        nvg::FontSize(m_size.x * 0.12f);
        string gear = tostring(m_gear);
        if (m_gear == -1) {
            gear = "R";
        }
        nvg::Text(m_center.x+margin.x-2, m_center.y+m_size.x * 0.1, gear);

        nvg::Stroke();
        nvg::ClosePath();
    }

    void RenderSettingsTab() override
    {
        if (UI::Button("Reset all settings to default"))
            BasicDigitalGaugeSettings::ResetAllToDefault();
        UI::BeginTabBar("Basic Digital Gauge Settings", UI::TabBarFlags::FittingPolicyResizeDown);
        if (UI::BeginTabItem("Speed")) {
            UI::BeginChild("Speed Settings");
            BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor = UI::InputColor4("Speed color", BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor);
            BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor = UI::InputColor4("Idle color (000 speed)", BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor);

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("RPM")) {
            UI::BeginChild("RPM Settings");
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColor = UI::InputColor4("RPM Color", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColor);
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackground = UI::InputColor4("Background color", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackground);

            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMHorizontalPos = UI::SliderInt("Horizontal position", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMHorizontalPos,0,300);
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMVerticalPos = UI::SliderInt("Vertical position", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMVerticalPos,0,100);
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMSize = UI::SliderInt("Horizontal size", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMSize,0,100);
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBlockSpace = UI::SliderFloat("Block space", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBlockSpace,0,10);

            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift = UI::Checkbox("Downshift/Upshift indicators", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift);

            if (BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift) {
                UI::TextDisabled("Theres values override the RPM color setting depending on the threshold");
                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshift = UI::SliderFloat("Downshift threshold", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshift, 0, 11000);
                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColor = UI::InputColor4("Downshift color", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColor);

                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshift = UI::SliderFloat("Upshift threshold", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshift, 0, 11000);
                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColor = UI::InputColor4("Upshift color", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColor);
            }

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Gears")) {
            UI::BeginChild("Gears Settings");
            BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor = UI::InputColor4("Gear color", BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor);

            BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshift = UI::Checkbox("Upshift indicator", BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshift);
            if (BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshift) {
                BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor = UI::InputColor4("Upshift color", BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor);
            }

            UI::EndChild();
            UI::EndTabItem();
        }
        UI::EndTabBar();
    }
}