# mruby-denko-board-milkv-duo

This mrbgem implements `Denko::Board`, with a similar interface to the [denko CRuby gem](https://github.com/denko-rb/denko), for the Milk-V Duo series of single board computers, allowing the `Denko` peripheral classes to be used.

## Supported Hardware
- Milk-V Duo 64M
- Milk-V Duo 256M
- Milk-V Duo S

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
  - [x] SH1107
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
  - [x] AHT10/AHT15
  - [x] AHT20/AHT21/AHT25
  - [x] AHT30
  - [x] BME280/BMP280
  - [x] BMP180
  - [ ] DHT
  - [ ] DS18B20
  - [x] GenericPIR
  - [ ] HCSR04
  - [x] HTU21D
  - [x] HTU31D
  - [ ] JSNSR04T
  - [ ] RCWL9620
  - [x] QMP6988 (only working on I2C::BitBang buses)
  - [x] SHT3X
  - [x] SHT4X (new, heater not implemented yet)
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
