namespace BasicGaugeSettings
{
    // Speed
    [Setting hidden]
    vec3 BasicGaugeSpeedColor = vec3(1.0f, 1.0f, 1.0f);

    [Setting hidden]
    float BasicGaugeSpeedColorAlpha = 1.0f;

    [Setting hidden]
    vec3 BasicGaugeSpeedIdleColor = vec3(0.0f, 0.0f, 0.0f);

    [Setting hidden]
    float BasicGaugeSpeedIdleColorAlpha = 0.5f;

    // RPM
    [Setting hidden]
    vec3 BasicGaugeRPMColor = vec3(1.0f, 0.65f, 0.1f);

    [Setting hidden]
    float BasicGaugeRPMColorAlpha = 1.0f;

    [Setting hidden]
    vec3 BasicGaugeRPMBackground = vec3(0.1f, 0.1f, 0.1f);

    [Setting hidden]
    float BasicGaugeRPMBackgroundAlpha = 0.0f;

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
    vec3 BasicGaugeRPMDownshiftColor = vec3(0.0f, 1.0f, 0.0f);

    [Setting hidden]
    float BasicGaugeRPMDownshiftColorAlpha = 1.0f;

    [Setting hidden]
    float BasicGaugeRPMUpshift = 10000;

    [Setting hidden]
    vec3 BasicGaugeRPMUpshiftColor = vec3(1.0f, 0.0f, 0.0f);

    [Setting hidden]
    float BasicGaugeRPMUpshiftColorAlpha = 1.0f;

    // Gears
    [Setting hidden]
    vec3 BasicGaugeGearColor = vec3(0.075f, 1.0f, 0.553f);

    [Setting hidden]
    float BasicGaugeGearColorAlpha = 1.0f;

    [Setting hidden]
    bool BasicGaugeGearUpshift = true;

    [Setting hidden]
    vec3 BasicGaugeGearUpshiftColor = vec3(1.0f, 0.0f, 0.0f);

    [Setting hidden]
    float BasicGaugeGearUpshiftColorAlpha = 1.0f;

    void ResetAllToDefault() {
        BasicGaugeSpeedColor = vec3(1.0f, 1.0f, 1.0f);
        BasicGaugeSpeedColorAlpha = 1.0f;
        BasicGaugeSpeedIdleColor = vec3(0.0f, 0.0f, 0.0f);
        BasicGaugeSpeedIdleColorAlpha = 0.5f;
        BasicGaugeRPMColor = vec3(1.0f, 0.65f, 0.1f);
        BasicGaugeRPMColorAlpha = 1.0f;
        BasicGaugeRPMBackground = vec3(0.1f, 0.1f, 0.1f);
        BasicGaugeRPMBackgroundAlpha = 0.0f;
        BasicGaugeRPMNeedle = true;
        BasicGaugeRPMArc = true;
        BasicGaugeRPMNeedleWidth = 0.02f;
        BasicGaugeRPMArcWidth = 0.04f;
        BasicGaugeRPMDownshiftUpshift = true;
        BasicGaugeRPMDownshift = 6500;
        BasicGaugeRPMDownshiftColor = vec3(0.0f, 1.0f, 0.0f);
        BasicGaugeRPMDownshiftColorAlpha = 1.0f;
        BasicGaugeRPMUpshift = 10000;
        BasicGaugeRPMUpshiftColor = vec3(1.0f, 0.0f, 0.0f);
        BasicGaugeRPMUpshiftColorAlpha = 1.0f;
        BasicGaugeGearColor = vec3(0.075f, 1.0f, 0.553f);
        BasicGaugeGearColorAlpha = 1.0f;
        BasicGaugeGearUpshift = true;
        BasicGaugeGearUpshiftColor = vec3(1.0f, 0.0f, 0.0f);
        BasicGaugeGearUpshiftColorAlpha = 1.0f;
    }
}