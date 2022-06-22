class TMTGauge : Gauge
{

    float startAngle = 90.0f;
    float endAngle = 423.0f;
    float angleTotal = endAngle - startAngle;

    int speedArcStep = 1;

    float maxSpeed = 999;

    nvg::Font m_SpeedFont;

    TMTGauge()
    {
        super();
        m_SpeedFont = nvg::LoadFont("src/Fonts/TMT/trackmania-turbo-chrono.ttf");
    }

    void RenderSpeed() override
    {
        vec4 speedColor = vec4(1,1,1,1);

        nvg::BeginPath();
        nvg::FontFace(m_SpeedFont);
        nvg::FontSize(m_size.x * 0.17f);
        int speed = Text::ParseInt(Text::Format("%.0f", Math::Abs(m_speed)));
        vec2 margin = vec2(-50, m_size.y * 0.01f);
        nvg::FillColor(speedColor);
        nvg::Text(m_center.x+margin.x, m_center.y+margin.y, Text::Format("%03d", speed));
        nvg::ClosePath();
    }

    void RenderRPM() override
    {

        vec4 arcColor = vec4(1,0,0,1);

        if (m_speed < 100) arcColor = vec4(1,0,0,1);
        else if (m_speed < 200) arcColor = vec4(1,0.5,0,1);
        else if (m_speed < 300) arcColor = vec4(1,1,0,1);
        else if (m_speed < 400) arcColor = vec4(0.5,1,0,1);
        else if (m_speed < 500) arcColor = vec4(0,1,0,1);
        else if (m_speed < 600) arcColor = vec4(0,1,0.5,1);
        else if (m_speed < 700) arcColor = vec4(0,1,1,1);
        else if (m_speed < 800) arcColor = vec4(0,0.5,1,1);
        else if (m_speed < 900) arcColor = vec4(0,0,1,1);
        else if (m_speed < 1000) arcColor = vec4(0,0,1,1);

        if (m_speed < 400) speedArcStep = 1;
        else if (m_speed < 800) speedArcStep = 2;
        else speedArcStep = 3;

        if (speedArcStep >= 1) {
            nvg::BeginPath();
            nvg::StrokeWidth(m_size.x * 0.06f);
            vec2 margin = vec2(0, -30);
            nvg::Arc(m_center+margin, m_size.x * 0.22, Utils::DegToRad(startAngle), Utils::DegToRad(startAngle + (angleTotal * (m_speed / 370))), nvg::Winding::CW);
            if (m_speed < 1) nvg::StrokeColor(vec4(0,0,0,0));
            else nvg::StrokeColor(arcColor);
            nvg::Stroke();
            nvg::ClosePath();
        }
        if (speedArcStep >= 2) {
            nvg::BeginPath();
            nvg::StrokeWidth(m_size.x * 0.06f);
            vec2 margin = vec2(0, -30);
            nvg::Arc(m_center+margin, m_size.x * 0.31, Utils::DegToRad(startAngle), Utils::DegToRad(startAngle + (angleTotal * ((m_speed - 400) / 370))), nvg::Winding::CW);
            nvg::StrokeColor(arcColor);
            nvg::Stroke();
            nvg::ClosePath();
        }
        if (speedArcStep >= 3) {
            nvg::BeginPath();
            nvg::StrokeWidth(m_size.x * 0.06f);
            vec2 margin = vec2(0, -30);
            nvg::Arc(m_center+margin, m_size.x * 0.4, Utils::DegToRad(startAngle), Utils::DegToRad(startAngle + (angleTotal * ((m_speed - 800) / 184))), nvg::Winding::CW);
            nvg::StrokeColor(arcColor);
            nvg::Stroke();
            nvg::ClosePath();
        }
    }
}