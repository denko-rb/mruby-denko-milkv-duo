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
  - [x] SH1106
  - [x] SSD1306

- I2C
  - [x] Bus (Hardware)
  - [x] BitBang
  - [x] Peripheral

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
  - [x] DS3231

- Sensor
  - [x] AHT10/AHT20 (need AHT20 example)
  - [x] BME280/BMP280
  - [x] BMP180
  - [ ] DHT
  - [ ] DS18B20
  - [x] GenericPIR
  - [ ] HCSR04
  - [x] HTU21D
  - [x] HTU31D
  - [ ] JSNSR04T
  - [ ] QMP6988
  - [ ] RCWL9620
  - [x] SHT3X
  - [x] VL53L0X

- SPI
  - [ ] Bus (Hardware)
  - [ ] BitBang
  - [ ] InputRegister
  - [ ] OutputRegister
  - [ ] Peripheral

- UART
  - [ ] Hardware
  - [ ] BitBang
