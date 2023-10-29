namespace Ascension2023GaugeSettings
{
    // Background
    [Setting hidden]
    vec4 Ascension2023GaugeBackgroundStrokeColor = vec4(1,1,1,1);

    // Speed
    [Setting hidden]
    vec4 Ascension2023GaugeSpeedColor = vec4(1,1,1,1);

    // Gear
    [Setting hidden]
    vec4 Ascension2023GaugeGearColor = vec4(0,0,0,1);

    [Setting hidden]
    vec4 Ascension2023GaugeGearBackgroundColor = vec4(1,1,1,1);

    void ResetAllToDefault() {
        Ascension2023GaugeBackgroundStrokeColor = vec4(1,1,1,1);
        Ascension2023GaugeSpeedColor = vec4(1,1,1,1);
        Ascension2023GaugeGearColor = vec4(0,0,0,1);
        Ascension2023GaugeGearBackgroundColor = vec4(1,1,1,1);
    }
}