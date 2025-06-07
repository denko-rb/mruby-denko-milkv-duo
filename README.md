# mruby-denko-milkv-duo

This mrbgem implements `Denko::Board` for the Milk-V Duo series of single board computers. The interface is compatible with the [Denko gem](https://github.com/denko-rb/denko) for CRuby. Most interface and peripheral classes are included in this mruby build, using source files directly from the CRuby gem.

## Supported Milk-V Boards
- Milk-V Duo 64M
- Milk-V Duo 256M
- Milk-V Duo S

## Limiations (relative to Denko on CRuby)
- UART hardware is available, but mruby support is not implemented yet.
  - The `UART` classes are automatically included in the build, but will not work.
  - Consequently, `Sensor::JSNSR04T` also will not work for now.
- Milk-V Duo has no on-board DACs (digital-to-analog converters).
  - The `AnalogIO::Output` class is included, and should work with external I2C or SPI DACs, when support is added for those in the future.
- Milk-V Duo has no on-board EEPROM.
  - The `EEPROM::Board` class is automatically included, but it will not work.
- `Sensor::QMP6988` works only on `I2C::BitBang` buses, not hardware. Unclear why.

## Peripherals to be implemented or tested for 0.15.0 release:

- Sensor
  - [ ] DHT
  - [ ] HCSR04
  - [ ] RCWL9620

## Install Instructions
- TODO

## Build Instructions
- On Ubuntu 24.04: `sudo apt install wget git make gcc`
- Install Ruby 3.3 or later, from `apt`, `rbenv` or elsewhere
- Clone mruby at [this commit](https://github.com/mruby/mruby/tree/1b39c7d7dab6c37d85a17ec4495a7c4c0c43d217) or later
- Clone the [Milk-V Duo SDK](https://github.com/milkv-duo/duo-sdk), so `duo-sdk` and `mruby` are in the same directory.
- Copy the file `build_config/denko_milkv_duo.rb` from this repo into `mruby/build_config`
- Edit `MILKV_DUO_VARIANT` in the copied file to match your board: 64m (no suffix), `256m` or `s`
- Modify the build config further, if needed
- In `mruby` root: `rake MRUBY_CONFIG=build_config/denko_milkv_duo.rb`
- When completed, the cross-compiled binaries will be in `mruby/build/milkv_duo/bin`
- Folow the install instructions above
