namespace BasicDigitalGaugeSettings
{
    // Speed
    [Setting hidden]
    vec3 BasicDigitalGaugeSpeedColor = vec3(1.0f, 1.0f, 1.0f);

    [Setting hidden]
    float BasicDigitalGaugeSpeedColorAlpha = 1.0f;

    [Setting hidden]
    vec3 BasicDigitalGaugeSpeedIdleColor = vec3(0.0f, 0.0f, 0.0f);

    [Setting hidden]
    float BasicDigitalGaugeSpeedIdleColorAlpha = 0.5f;

    // RPM
    [Setting hidden]
    vec3 BasicDigitalGaugeRPMColor = vec3(1.0f, 1.0f, 1.0f);

    [Setting hidden]
    float BasicDigitalGaugeRPMColorAlpha = 1.0f;

    [Setting hidden]
    vec3 BasicDigitalGaugeRPMBackground = vec3(0.1f, 0.1f, 0.1f);

    [Setting hidden]
    float BasicDigitalGaugeRPMBackgroundAlpha = 0.8f;

    [Setting hidden]
    int BasicDigitalGaugeRPMHorizontalPos = 160;

    [Setting hidden]
    int BasicDigitalGaugeRPMVerticalPos = 50;

    [Setting hidden]
    float BasicDigitalGaugeRPMBlockSpace = 4.0f;

    [Setting hidden]
    int BasicDigitalGaugeRPMSize = 0;

    [Setting hidden]
    bool BasicDigitalGaugeRPMDownshiftUpshift = true;

    [Setting hidden]
    float BasicDigitalGaugeRPMDownshift = 6500;

    [Setting hidden]
    vec3 BasicDigitalGaugeRPMDownshiftColor = vec3(1.0f, 1.0f, 1.0f);

    [Setting hidden]
    float BasicDigitalGaugeRPMDownshiftColorAlpha = 1.0f;

    [Setting hidden]
    float BasicDigitalGaugeRPMUpshift = 10000;

    [Setting hidden]
    vec3 BasicDigitalGaugeRPMUpshiftColor = vec3(1.0f, 0.0f, 0.0f);

    [Setting hidden]
    float BasicDigitalGaugeRPMUpshiftColorAlpha = 1.0f;

    // Gears
    [Setting hidden]
    vec3 BasicDigitalGaugeGearColor = vec3(0.075f, 1.0f, 0.553f);

    [Setting hidden]
    float BasicDigitalGaugeGearColorAlpha = 1.0f;

    [Setting hidden]
    bool BasicDigitalGaugeGearUpshift = true;

    [Setting hidden]
    vec3 BasicDigitalGaugeGearUpshiftColor = vec3(1.0f, 0.0f, 0.0f);

    [Setting hidden]
    float BasicDigitalGaugeGearUpshiftColorAlpha = 1.0f;

    void ResetAllToDefault()
    {
        BasicDigitalGaugeSpeedColor = vec3(1.0f, 1.0f, 1.0f);
        BasicDigitalGaugeSpeedColorAlpha = 1.0f;
        BasicDigitalGaugeSpeedIdleColor = vec3(0.0f, 0.0f, 0.0f);
        BasicDigitalGaugeSpeedIdleColorAlpha = 0.5f;

        BasicDigitalGaugeRPMColor = vec3(1.0f, 1.0f, 1.0f);
        BasicDigitalGaugeRPMColorAlpha = 1.0f;
        BasicDigitalGaugeRPMBackground = vec3(0.1f, 0.1f, 0.1f);
        BasicDigitalGaugeRPMBackgroundAlpha = 0.8f;
        BasicDigitalGaugeRPMHorizontalPos = 160;
        BasicDigitalGaugeRPMVerticalPos = 50;
        BasicDigitalGaugeRPMBlockSpace = 4.0f;
        BasicDigitalGaugeRPMSize = 0;
        BasicDigitalGaugeRPMDownshiftUpshift = true;
        BasicDigitalGaugeRPMDownshift = 6500;
        BasicDigitalGaugeRPMDownshiftColor = vec3(1.0f, 1.0f, 1.0f);
        BasicDigitalGaugeRPMDownshiftColorAlpha = 1.0f;
        BasicDigitalGaugeRPMUpshift = 10000;
        BasicDigitalGaugeRPMUpshiftColor = vec3(1.0f, 0.0f, 0.0f);
        BasicDigitalGaugeRPMUpshiftColorAlpha = 1.0f;

        BasicDigitalGaugeGearColor = vec3(0.075f, 1.0f, 0.553f);
        BasicDigitalGaugeGearColorAlpha = 1.0f;
        BasicDigitalGaugeGearUpshift = true;
        BasicDigitalGaugeGearUpshiftColor = vec3(1.0f, 0.0f, 0.0f);
        BasicDigitalGaugeGearUpshiftColorAlpha = 1.0f;
    }
}