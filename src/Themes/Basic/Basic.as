class BasicGauge : Gauge
{

    float startAngle = 110.0f;
    float endAngle = 335.0f;
    float angleTotal = endAngle - startAngle;

    nvg::Font m_GearFont;
    nvg::Font m_SpeedFont;

    BasicGauge()
    {
        super();
        m_GearFont = nvg::LoadFont("src/Fonts/Oswald-Demi-Bold-Italic.ttf");
        m_SpeedFont = nvg::LoadFont("src/Fonts/Oswald-Light-Italic.ttf");
    }

    void RenderBackground() override
    {
        if (BasicGaugeSettings::BasicGaugeBackgroundVisible) {
            auto image = Images::CachedFromURL(BasicGaugeSettings::BasicGaugeBackgroundURL);
            if (image.m_texture !is null){
                nvg::BeginPath();
                vec2 imageSize = image.m_texture.GetSize() * BasicGaugeSettings::BasicGaugeBackgroundScale;
                vec2 imageCenterPos = vec2(imageSize.x / 2.0f, imageSize.y / 2.0f);
                nvg::Rect(m_center - imageCenterPos, imageSize);
                nvg::FillPaint(nvg::TexturePattern(m_center - imageCenterPos, imageSize, 0, image.m_texture, BasicGaugeSettings::BasicGaugeBackgroundAlpha));
                nvg::Fill();
                nvg::ClosePath();
            }
        }
    }

    void RenderSpeed() override
    {
        nvg::BeginPath();
        nvg::FontFace(m_SpeedFont);
        nvg::FontSize(m_size.x * 0.2f);
        // remove negative sign
        int speed = Text::ParseInt(Text::Format("%.0f", Math::Abs(m_speed)));
        vec2 margin = vec2(m_size.x * 0.07f, 60 + (m_size.y * 0.1f));
        if (m_speed > -1 && m_speed < 1) {
            nvg::FillColor(BasicGaugeSettings::BasicGaugeSpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "000");
        } else if (speed > 0 && speed < 10) {
            nvg::FillColor(BasicGaugeSettings::BasicGaugeSpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "00");

            vec2 bounds = nvg::TextBounds("00");

            nvg::FillColor(BasicGaugeSettings::BasicGaugeSpeedColor);
            nvg::Text(m_center.x+margin.x+bounds.x, m_center.y+margin.y, tostring(speed));
        } else if (speed >= 10 && speed < 100) {
            nvg::FillColor(BasicGaugeSettings::BasicGaugeSpeedIdleColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, "0");

            vec2 bounds = nvg::TextBounds("0");

            nvg::FillColor(BasicGaugeSettings::BasicGaugeSpeedColor);
            nvg::Text(m_center.x+margin.x+bounds.x, m_center.y+margin.y, tostring(speed));
        } else {
            nvg::FillColor(BasicGaugeSettings::BasicGaugeSpeedColor);
            nvg::Text(m_center.x+margin.x, m_center.y+margin.y, Text::Format("%03d", speed));
        }
        nvg::ClosePath();
    }

    void RenderRPM() override
    {
        // background
        nvg::BeginPath();
        nvg::StrokeColor(BasicGaugeSettings::BasicGaugeRPMBackground);
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
                nvg::StrokeColor(BasicGaugeSettings::BasicGaugeRPMDownshiftColor);
            } else if (m_rpm >= BasicGaugeSettings::BasicGaugeRPMUpshift && BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift) {
                nvg::StrokeColor(BasicGaugeSettings::BasicGaugeRPMUpshiftColor);
            } else {
                nvg::StrokeColor(BasicGaugeSettings::BasicGaugeRPMColor);
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
                nvg::StrokeColor(BasicGaugeSettings::BasicGaugeRPMDownshiftColor);
            } else if (m_rpm >= BasicGaugeSettings::BasicGaugeRPMUpshift && BasicGaugeSettings::BasicGaugeRPMDownshiftUpshift) {
                nvg::StrokeColor(BasicGaugeSettings::BasicGaugeRPMUpshiftColor);
            } else {
                nvg::StrokeColor(BasicGaugeSettings::BasicGaugeRPMColor);
            }
            nvg::Stroke();
            nvg::ClosePath();
        }
    }

    void RenderGear() override
    {
        nvg::BeginPath();
        nvg::StrokeWidth(m_size.x * 0.01f);
        nvg::Circle(m_center, m_size.x * 0.08);

        if (m_rpm >= BasicGaugeSettings::BasicGaugeRPMUpshift && BasicGaugeSettings::BasicGaugeGearUpshift) {
            nvg::FillColor(BasicGaugeSettings::BasicGaugeGearUpshiftColor);
            nvg::StrokeColor(BasicGaugeSettings::BasicGaugeGearUpshiftColor);
        } else {
            nvg::FillColor(BasicGaugeSettings::BasicGaugeGearColor);
            nvg::StrokeColor(BasicGaugeSettings::BasicGaugeGearColor);
        }

        // gear text
        nvg::TextAlign(nvg::Align::Center);
        nvg::FontFace(m_GearFont);
        nvg::FontSize(m_size.x * 0.12f);
        string gear = tostring(m_gear);
        if (m_gear == -1) gear = "R";
        nvg::Text(m_center.x-1, m_center.y+m_size.x * 0.045, gear);

        nvg::Stroke();
        nvg::ClosePath();
    }

    void RenderSettingsTab() override
    {
        if (UI::Button("Reset all settings to default")) {
            BasicGaugeSettings::ResetAllToDefault();
        }
        UI::BeginTabBar("Basic Gauge Settings", UI::TabBarFlags::FittingPolicyResizeDown);
        if (UI::BeginTabItem("Background")) {
            UI::BeginChild("Background Settings");
            BasicGaugeSettings::BasicGaugeBackgroundVisible = UI::Checkbox("Display background", BasicGaugeSettings::BasicGaugeBackgroundVisible);

            if (BasicGaugeSettings::BasicGaugeBackgroundVisible) {
                BasicGaugeSettings::BasicGaugeBackgroundURL = UI::InputText("Image URL", BasicGaugeSettings::BasicGaugeBackgroundURL);
                BasicGaugeSettings::BasicGaugeBackgroundAlpha = UI::SliderFloat("Alpha", BasicGaugeSettings::BasicGaugeBackgroundAlpha,0,1);
                BasicGaugeSettings::BasicGaugeBackgroundScale = UI::SliderFloat("Scale", BasicGaugeSettings::BasicGaugeBackgroundScale,0.1f,0.5f);
           }

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Speed")) {
            UI::BeginChild("Speed Settings");
            BasicGaugeSettings::BasicGaugeSpeedColor = UI::InputColor4("Speed color", BasicGaugeSettings::BasicGaugeSpeedColor);
            BasicGaugeSettings::BasicGaugeSpeedIdleColor = UI::InputColor4("Idle color (000 speed)", BasicGaugeSettings::BasicGaugeSpeedIdleColor);

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("RPM")) {
            UI::BeginChild("RPM Settings");
            BasicGaugeSettings::BasicGaugeRPMColor = UI::InputColor4("RPM Color", BasicGaugeSettings::BasicGaugeRPMColor);
            BasicGaugeSettings::BasicGaugeRPMBackground = UI::InputColor4("Background color", BasicGaugeSettings::BasicGaugeRPMBackground);

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
                BasicGaugeSettings::BasicGaugeRPMDownshiftColor = UI::InputColor4("Downshift color", BasicGaugeSettings::BasicGaugeRPMDownshiftColor);

                BasicGaugeSettings::BasicGaugeRPMUpshift = UI::SliderFloat("Upshift threshold", BasicGaugeSettings::BasicGaugeRPMUpshift, 0, 11000);
                BasicGaugeSettings::BasicGaugeRPMUpshiftColor = UI::InputColor4("Upshift color", BasicGaugeSettings::BasicGaugeRPMUpshiftColor);
            }

            UI::EndChild();
            UI::EndTabItem();
        }
        if (UI::BeginTabItem("Gears")) {
            UI::BeginChild("Gears Settings");
            BasicGaugeSettings::BasicGaugeGearColor = UI::InputColor4("Gear color", BasicGaugeSettings::BasicGaugeGearColor);

            BasicGaugeSettings::BasicGaugeGearUpshift = UI::Checkbox("Upshift indicator", BasicGaugeSettings::BasicGaugeGearUpshift);
            if (BasicGaugeSettings::BasicGaugeGearUpshift) {
                BasicGaugeSettings::BasicGaugeGearUpshiftColor = UI::InputColor4("Upshift color", BasicGaugeSettings::BasicGaugeGearUpshiftColor);
            }

            UI::EndChild();
            UI::EndTabItem();
        }
        UI::EndTabBar();
    }
}