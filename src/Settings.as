namespace PluginSettings
{
    [Setting name="Show Dashboard" category="General"]
    bool ShowDashboard = true;

    [Setting name="Hide when not playing" category="General"]
    bool HideWhenNotPlaying = true;

    [Setting name="Locator Mode (move dashboard)" category="General"]
    bool LocatorMode = false;

    enum Themes {
        Arc
    }

    [Setting name="Theme" category="General"]
    Themes Theme = Themes::Arc;

    [Setting name="Position" category="General"]
    vec2 Position = vec2(1.0f, 1.02f);

    [Setting name="Size" category="General"]
    vec2 Size = vec2(250, 200);

    [Setting color name="RPM Color" category="RPM"]
    vec4 RPMColor = vec4(1.0f, 0.65f, 0.1f, 1.0f);

    [Setting color name="RPM Background" category="RPM"]
    vec4 RPMBackground = vec4(0.1f, 0.1f, 0.1f, 0.0f);

    [Setting name="Downshift/Upshift indicator" category="RPM"]
    bool RPMDownshiftUpshift = true;

    [Setting name="Downshift threshold" drag min=0 max=11000 category="RPM"]
    float RPMDownshift = 6500;

    [Setting color name="Downshift threshold color" category="RPM"]
    vec4 RPMDownshiftColor = vec4(0.0f, 1.0f, 0.0f, 1.0f);

    [Setting name="Upshift threshold" drag min=0 max=11000 category="RPM"]
    float RPMUpshift = 10000;

    [Setting color name="Upshift threshold color" category="RPM"]
    vec4 RPMUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);

    [Setting color name="Gear color" category="Gear"]
    vec4 GearColor = vec4(0.075f, 1.0f, 0.553f, 1.0f);

    [Setting name="Upshift indicator" category="Gear"]
    bool GearUpshift = true;

    [Setting color name="Upshift threshold color" category="Gear"]
    vec4 GearUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);

    [Setting color name="Speed color" category="Speed"]
    vec4 SpeedColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting color name="Idle color (000 speed)" category="Speed"]
    vec4 SpeedIdleColor = vec4(0.0f, 0.0f, 0.0f, 0.5f);
}