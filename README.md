# mruby-denko-milkv-duo

This mrbgem implements `Denko::Board` for the Milk-V Duo series of single board computers. Its interface is compatible with the Denko [CRuby gem](https://github.com/denko-rb/denko), so most of the interface and peripheral classes from that gem are directly usable (and included) in this mruby build.

## Supported Milk-V Boards
- Milk-V Duo 64M
- Milk-V Duo 256M
- Milk-V Duo S

## Limiations (relative to Denko on CRuby)
- UART hardware is available, but mruby support is not implemented yet.
  - The `UART` classes are automatically included in the build, but will not work.
  - Consequently, `Sensor::JSNSR04T` also will not work for now.
- Milk-V Duo has no on-board DACs (digital-to-analog converters). The `AnalogIO::Output` class is included, and should work with external I2C or SPI DACs, when support is added for those in the future.
- Milk-V Duo has no on-board EEPROM. The `EEPROM::Board` class is automatically included, but it will not work.
- `Sensor::QMP6988` works only on `I2C::BitBang` buses, not hardware I2C. Unclear why.

## Peripherals to be implemented or tested for 0.15.0 release:

- Sensor
  - [ ] DHT
  - [ ] HCSR04
  - [ ] RCWL9620

## Install Instructions
- Download the appropriate Buildroot Linux image for your board, from the [official repo](https://github.com/milkv-duo/duo-buildroot-sdk/releases).
- Using [balenaEtcher](https://www.balena.io/etcher) or similar, flash the image to a micro SD card.
- Insert the SD card into your Duo and connect it to your computer.
- Download and unzip the mruby binaries for your board, from the [releases section](https://github.com/denko-rb/mruby-denko-milkv-duo/releases) of this repo.
- The Milk-V Duo should have created a network interface on your computer, so you can SSH/SCP into it. The default username is `root` and password is `milkv`.
- Copy the binaries onto the board:
  ```console
  # Linux & Recent Macs
  scp -O UNZIPPED_BINARY_FOLDER/* root@192.168.42.1:/usr/local/bin
  ```
  ```console
  # Oleder Macs
  scp UNZIPPED_BINARY_FOLDER/* root@192.168.42.1:/usr/local/bin
  ```
- SSH into the board with `ssh root@192.168.42.1`.
- Try the `mirb` shell, or copy over examples from [this](examples) folder, and try them with `mruby FILENAME.rb`.
- If you have issues with PWM / I2C / SPI, please read the [pinmux](#pinmux) section below.

### Pinmux

- Some features of the Duo are multiplexed onto the same pins.
- Use `duo-pinmux` to set them up _before_ using them. See [official docs](https://milkv.io/docs/duo/application-development/pinmux) for more info.
- **NOTE:** What the documentation refers to as `SPI2` (for Duo and Duo 256M) shows up as `/dev/spidev0` in Linux, so give `index: 0` (or no index at all) to use that hardware SPI. This is also likely the case for `SPI3` on the Duo S, but that is untested yet.

## Build Instructions
- On Ubuntu 24.04: `sudo apt install wget git make gcc`
- Install Ruby 3.3 or later, from `apt`, `rbenv` or elsewhere
- Clone mruby at [this commit](https://github.com/mruby/mruby/tree/1b39c7d7dab6c37d85a17ec4495a7c4c0c43d217) or later
- Clone the [Milk-V Duo SDK](https://github.com/milkv-duo/duo-sdk), so `duo-sdk` and `mruby` are in the same directory.
- Copy the file `build_config/denko_milkv_duo.rb` from this repo into `mruby/build_config`
- Edit `MILKV_DUO_VARIANT` in the copied file to match your board: 64m (no suffix), `256m` or `s`
- Modify the build config further, if needed
- In `mruby` root: `rake MRUBY_CONFIG=build_config/denko_milkv_duo.rb`
- When completed, the cross-compiled binaries will be in `mruby/build/#{MILKV_DUO_VARIANT}/bin`
- Folow the install instructions above
