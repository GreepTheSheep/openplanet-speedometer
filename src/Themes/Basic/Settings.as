namespace BasicGaugeSettings
{

    // Background
    [Setting hidden]
    bool BasicGaugeBackgroundVisible = false;

    [Setting hidden]
    string BasicGaugeBackgroundURL = "https://i.imgur.com/sz01oX3.png";

    [Setting hidden]
    float BasicGaugeBackgroundScale = 0.42f;

    [Setting hidden]
    float BasicGaugeBackgroundAlpha = 1.0f;

    // Speed
    [Setting hidden]
    vec4 BasicGaugeSpeedColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting hidden]
    vec4 BasicGaugeSpeedIdleColor = vec4(0.0f, 0.0f, 0.0f, 0.5f);

    // RPM
    [Setting hidden]
    vec4 BasicGaugeRPMColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting hidden]
    vec4 BasicGaugeRPMBackground = vec4(0.1f, 0.1f, 0.1f, 0.0f);

    [Setting hidden]
    bool BasicGaugeRPMNeedle = true;

    [Setting hidden]
    bool BasicGaugeRPMArc = true;

    [Setting hidden]
    float BasicGaugeRPMNeedleWidth = 0.02f;

    [Setting hidden]
    float BasicGaugeRPMArcWidth = 0.04f;

    [Setting hidden]
    bool BasicGaugeRPMDownshiftUpshift = true;

    [Setting hidden]
    float BasicGaugeRPMDownshift = 6500;

    [Setting hidden]
    vec4 BasicGaugeRPMDownshiftColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting hidden]
    float BasicGaugeRPMUpshift = 10000;

    [Setting hidden]
    vec4 BasicGaugeRPMUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);

    // Gears
    [Setting hidden]
    vec4 BasicGaugeGearColor = vec4(0.075f, 1.0f, 0.553f, 1.0f);

    [Setting hidden]
    bool BasicGaugeGearUpshift = true;

    [Setting hidden]
    vec4 BasicGaugeGearUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);

    void ResetAllToDefault() {
        BasicGaugeBackgroundVisible = false;
        BasicGaugeBackgroundURL = "https://i.imgur.com/sz01oX3.png";
        BasicGaugeBackgroundScale = 0.42f;
        BasicGaugeBackgroundAlpha = 1.0f;

        BasicGaugeSpeedColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
        BasicGaugeSpeedIdleColor = vec4(0.0f, 0.0f, 0.0f, 0.5f);

        BasicGaugeRPMColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
        BasicGaugeRPMBackground = vec4(0.1f, 0.1f, 0.1f, 0.0f);
        BasicGaugeRPMNeedle = true;
        BasicGaugeRPMArc = true;
        BasicGaugeRPMNeedleWidth = 0.02f;
        BasicGaugeRPMArcWidth = 0.04f;
        BasicGaugeRPMDownshiftUpshift = true;
        BasicGaugeRPMDownshift = 6500;
        BasicGaugeRPMDownshiftColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
        BasicGaugeRPMUpshift = 10000;
        BasicGaugeRPMUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);

        BasicGaugeGearColor = vec4(0.075f, 1.0f, 0.553f, 1.0f);
        BasicGaugeGearUpshift = true;
        BasicGaugeGearUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
    }
}