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
        RenderBackground();
        RenderSpeed();
        RenderRPM();
        RenderGear();
    }

    void RenderBackground(){}

    void RenderSpeed(){}

    void RenderRPM(){}

    void RenderGear(){}

    void RenderSettingsTab() {
        UI::Text("This theme does not have any settings.");
    }
}