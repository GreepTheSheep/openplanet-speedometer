namespace BasicDigitalGaugeSettings
{
    // Speed
    [Setting hidden]
    vec4 BasicDigitalGaugeSpeedColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting hidden]
    vec4 BasicDigitalGaugeSpeedIdleColor = vec4(0.0f, 0.0f, 0.0f, 0.5f);

    // RPM
    [Setting hidden]
    vec4 BasicDigitalGaugeRPMColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting hidden]
    vec4 BasicDigitalGaugeRPMBackground = vec4(0.1f, 0.1f, 0.1f, 0.8f);

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
    vec4 BasicDigitalGaugeRPMDownshiftColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    [Setting hidden]
    float BasicDigitalGaugeRPMUpshift = 10000;

    [Setting hidden]
    vec4 BasicDigitalGaugeRPMUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);

    // Gears
    [Setting hidden]
    vec4 BasicDigitalGaugeGearColor = vec4(0.075f, 1.0f, 0.553f, 1.0f);

    [Setting hidden]
    bool BasicDigitalGaugeGearUpshift = true;

    [Setting hidden]
    vec4 BasicDigitalGaugeGearUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);

    void ResetAllToDefault()
    {
        BasicDigitalGaugeSpeedColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
        BasicDigitalGaugeSpeedIdleColor = vec4(0.0f, 0.0f, 0.0f, 0.5f);

        BasicDigitalGaugeRPMColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
        BasicDigitalGaugeRPMBackground = vec4(0.1f, 0.1f, 0.1f, 0.8f);
        BasicDigitalGaugeRPMHorizontalPos = 160;
        BasicDigitalGaugeRPMVerticalPos = 50;
        BasicDigitalGaugeRPMBlockSpace = 4.0f;
        BasicDigitalGaugeRPMSize = 0;
        BasicDigitalGaugeRPMDownshiftUpshift = true;
        BasicDigitalGaugeRPMDownshift = 6500;
        BasicDigitalGaugeRPMDownshiftColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
        BasicDigitalGaugeRPMUpshift = 10000;
        BasicDigitalGaugeRPMUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);

        BasicDigitalGaugeGearColor = vec4(0.075f, 1.0f, 0.553f, 1.0f);
        BasicDigitalGaugeGearUpshift = true;
        BasicDigitalGaugeGearUpshiftColor = vec4(1.0f, 0.0f, 0.0f, 1.0f);
    }
}