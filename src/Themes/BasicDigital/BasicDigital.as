class BasicDigitalGauge : Gauge
{
    Resources::Font@ m_GearFont;
    Resources::Font@ m_SpeedFont;

    BasicDigitalGauge()
    {
        super();
        @m_GearFont = Resources::GetFont("src/Fonts/Oswald-Demi-Bold-Italic.ttf");
        @m_SpeedFont = Resources::GetFont("src/Fonts/Oswald-Light-Italic.ttf");
    }

    void RenderSpeed() override
    {
        vec4 speedColor = vec4(BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor.x, BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor.y, BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor.z, BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColorAlpha);
        vec4 speedColorIdle = vec4(BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor.x, BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor.y, BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor.z, BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColorAlpha);

        nvg::BeginPath();
        nvg::FontFace(m_SpeedFont);
        nvg::FontSize(m_size.x * 0.28f);
        // remove negative sign
        int speed = Text::ParseInt(Text::Format("%.0f", Math::Abs(m_speed)));
        vec2 margin = vec2(-20, 40);
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
        vec4 RPMColor = vec4(BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColor.x, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColor.y, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColor.z, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColorAlpha);
        vec4 RPMBackground = vec4(BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackground.x, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackground.y, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackground.z, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackgroundAlpha);
        vec4 RPMDownshiftColor = vec4(BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColor.x, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColor.y, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColor.z, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColorAlpha);
        vec4 RPMUpshiftColor = vec4(BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColor.x, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColor.y, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColor.z, BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColorAlpha);
        const float blockPadding = 6.0f;
        const float blockSpacing = 4.0f;
        vec2 blockSize = vec2(6, m_size.y - blockPadding * 2);
        float blockSpace = blockSize.x + blockSpacing - 4;
        int numDots = int((m_size.x - blockPadding) / blockSpace);

        for (int i = 8; i < numDots; i++) {
            float scaledRpm = i / float(numDots) * m_maxRpm;

            nvg::BeginPath();
            nvg::RoundedRect(m_center.x + i * blockSpace + blockPadding - 165, m_center.y + blockPadding + 50, blockSize.x - 10, blockSize.y - 168, 4);
            if (m_rpm > m_minRpm && m_rpm >= scaledRpm) {
                if (m_rpm <= BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshift && BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift) {
                    nvg::FillColor(RPMDownshiftColor);
                } else if (m_rpm >= BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshift && BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift) {
                    nvg::FillColor(RPMUpshiftColor);
                } else {
                    nvg::FillColor(RPMColor);
                }
            } else {
                nvg::FillColor(RPMBackground);
            }
            nvg::Fill();
        }
    }

    void RenderGear() override
    {
        vec4 GearColor = vec4(BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor.x, BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor.y, BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor.z, BasicDigitalGaugeSettings::BasicDigitalGaugeGearColorAlpha);
        vec4 GearUpshiftColor = vec4(BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor.x, BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor.y, BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor.z, BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColorAlpha);
        vec2 margin = vec2(-55, 20);
        nvg::BeginPath();
        nvg::StrokeWidth(m_size.x * 0.01f);
        nvg::Circle(m_center+margin, m_size.x * 0.08);

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
        nvg::Text(m_center.x+margin.x-2, m_center.y+margin.y+11, gear);

        nvg::Stroke();
        nvg::ClosePath();
    }

    void RenderSettingsTab() override
    {
        UI::BeginTabBar("Basic Digital Gauge Settings", UI::TabBarFlags::FittingPolicyResizeDown);
        if (UI::BeginTabItem("Speed")) {
            UI::BeginChild("Speed Settings");
            BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor = UI::InputColor3("Speed color", BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColor);
            BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColorAlpha = UI::SliderFloat("Speed alpha", BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedColorAlpha,0,1);
            BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor = UI::InputColor3("Idle color (000 speed)", BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColor);
            BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColorAlpha = UI::SliderFloat("Idle alpha", BasicDigitalGaugeSettings::BasicDigitalGaugeSpeedIdleColorAlpha,0,1);

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("RPM")) {
            UI::BeginChild("RPM Settings");
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColor = UI::InputColor3("RPM Color", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColor);
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColorAlpha = UI::SliderFloat("RPM alpha", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMColorAlpha,0,1);
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackground = UI::InputColor3("Background color", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackground);
            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackgroundAlpha = UI::SliderFloat("Background alpha", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMBackgroundAlpha,0,1);

            BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift = UI::Checkbox("Downshift/Upshift indicators", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift);

            if (BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftUpshift) {
                UI::TextDisabled("Theres values override the RPM color setting depending on the threshold");
                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshift = UI::SliderFloat("Downshift threshold", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshift, 0, 11000);
                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColor = UI::InputColor3("Downshift color", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColor);
                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColorAlpha = UI::SliderFloat("Downshift alpha", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMDownshiftColorAlpha,0,1);

                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshift = UI::SliderFloat("Upshift threshold", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshift, 0, 11000);
                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColor = UI::InputColor3("Upshift color", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColor);
                BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColorAlpha = UI::SliderFloat("Upshift alpha", BasicDigitalGaugeSettings::BasicDigitalGaugeRPMUpshiftColorAlpha,0,1);
            }

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Gears")) {
            UI::BeginChild("Gears Settings");
            BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor = UI::InputColor3("Gear color", BasicDigitalGaugeSettings::BasicDigitalGaugeGearColor);
            BasicDigitalGaugeSettings::BasicDigitalGaugeGearColorAlpha = UI::SliderFloat("Gear alpha", BasicDigitalGaugeSettings::BasicDigitalGaugeGearColorAlpha,0,1);

            BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshift = UI::Checkbox("Upshift indicator", BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshift);
            if (BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshift) {
                BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor = UI::InputColor3("Upshift color", BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColor);
                BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColorAlpha = UI::SliderFloat("Upshift alpha", BasicDigitalGaugeSettings::BasicDigitalGaugeGearUpshiftColorAlpha,0,1);
            }

            UI::EndChild();
            UI::EndTabItem();
        }
        UI::EndTabBar();
    }
}