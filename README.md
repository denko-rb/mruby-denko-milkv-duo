# mruby-denko-board-milkv-duo

This mrbgem implements `Denko::Board`, with a similar interface to the [denko CRuby gem](https://github.com/denko-rb/denko), for the Milk-V Duo series of single board computers, allowing the `Denko` peripheral classes to be used.

## Component implementation status for parity with denko 0.14:

- AnalogIO
  - [ ] ADS1100
  - [ ] ADS1115
  - [ ] ADS1118
  - [x] Input
  - [x] Joystick
  - [ ] Output (not on Milk-V Duo)
  - [x] Potentiometer

- DigitalIO
  - [x] Button
  - [x] Input
  - [x] Output
  - [x] Relay
  - [x] RotaryEncoder

- Display
  - [x] Canvas
  - [x] HD44780
  - [ ] SH1106
  - [ ] SSD1306

- I2C
  - [ ] Bus (Hardware)
  - [ ] BitBang
  - [ ] Peripheral

- LED
  - [ ] APA102
  - [x] Base
  - [x] RGB
  - [x] SevenSegment
  - [ ] WS2812

- Motor
  - [x] A3967 (Stepper driver)
  - [x] L298 (H-Bridge Driver)
  - [x] Servo

- OneWire
  - [ ] Bus
  - [ ] Peripheral

- PulseIO
  - [x] Buzzer
  - [ ] IROutput
  - [x] PWMOutput

- RTC
  - [ ] DS3231

- Sensor
  - [ ] AHT10/AHT20
  - [ ] BME280/BMP280
  - [ ] DHT
  - [x] GenericPIR
  - [ ] HCSR04
  - [ ] HTU21D
  - [ ] HTU31D
  - [ ] JSNSR04T
  - [ ] QMP6988
  - [ ] RCWL9620
  - [ ] SHT3X
  - [ ] VL53L0X

- SPI
  - [ ] Bus (Hardware)
  - [ ] BitBang
  - [ ] InputRegister
  - [ ] OutputRegister
  - [ ] Peripheral

- UART
  - [ ] Hardware
  - [ ] BitBang
