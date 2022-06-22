# Creating your own theme

**Warning**: make sure you're running the Club edition of your game if you want to use on Trackmania (2020), [more details here](https://openplanet.dev/next/club)

**A theme is a class that extends the [Gauge](../Gauge.as) class.**

Any theme is using the [NanoVG API for Openplanet](https://openplanet.dev/docs/api/nvg)

## Methods that you need to use

- `void RenderBackground()`: render the background of the gauge
- `void RenderSpeed()`: render the speed counter
- `void RenderRPM()`: render the RPM gauge
- `void RenderGear()`: render the gear indicator
- `void RenderSettingsTab()`: render the theme settings on the plugin settings tab

Don't forget to add `override` at the method so you can override from the base class.

## Variables that you can use

Any variable in bold means that the variable is recommended to use.

- **vec2 `m_resPos`** : the calculated position of the gauge depending on the resolution of the game
- **vec2 `m_size`** : the size of the gauge
- **vec2 `m_center`** : the center of the gauge
- **float `m_rpm`** : the RPM of the vehicle (values between 0 and 11000, defined in `float m_maxRpm`)
- **float `m_speed`** : the speed of the vehicle
- **int `m_gear`** : the gear of the vehicle

- vec2 `m_pos` : the position of the gauge
- float `m_minRpm` : Minimal RPM to avoid flickering at engine idle
- float `m_maxRpm` : Maximal RPM to avoid flickering at engine idle