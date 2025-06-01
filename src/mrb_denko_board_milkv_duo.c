// Source from mruby-milkv-duo.
#include "../ext/mruby-milkv-duo/src/mrb_milkv_duo.c"

static mrb_value
mrb_milkv_variant(mrb_state *mrb, mrb_value self)
{
  return mrb_str_new_cstr(mrb, MILKV_DUO_VARIANT);
}

void
mrb_mruby_denko_milkv_duo_gem_init(mrb_state* mrb) {
  // Duo module from mruby-milkv-duo gem.
  mrb_mruby_milkv_duo_gem_init(mrb);

  // Denko module
  struct RClass *mrb_Denko = mrb_define_module(mrb, "Denko");

  // Denko::Board class
  struct RClass *mrb_Denko_Board = mrb_define_class_under(mrb, mrb_Denko, "Board", mrb->object_class);

  // Pass a C constant through to mruby, defined inside Denko::Board.
  #define define_const(SYM) \
  do { \
    mrb_define_const(mrb, mrb_Denko_Board, #SYM, mrb_fixnum_value(SYM)); \
  } while (0)

  // Denko::Board constants
  define_const(PINMODE_NOT_SET);
  define_const(PINMODE_INPUT);
  define_const(PINMODE_OUTPUT);
  define_const(PINMODE_INTERRUPT);
  define_const(LOW);
  define_const(HIGH);

  // Save user from calling Duo.setup each script.
  // Already done in mruby-milkv-duo gem?
  mrb_wx_setup(mrb, mrb_nil_value());

  /***************************************************************************/
  /*                    Instance methods on Denko::Board                     */
  /*                                                                         */
  /* Methods starting with underscore are wrapped by "no underscore" methods */
  /* defined in Ruby.                                                        */
  /*                                                                         */
  /***************************************************************************/
  //
  // System
  mrb_define_method(mrb, mrb_Denko_Board, "variant",          mrb_milkv_variant,      MRB_ARGS_REQ(0));
  mrb_define_method(mrb, mrb_Denko_Board, "micro_delay",      mrb_micro_delay,        MRB_ARGS_REQ(1));

  // Digital I/O
  mrb_define_method(mrb, mrb_Denko_Board, "valid_gpio",       mrb_valid_gpio,         MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb_Denko_Board, "_set_pin_mode",    mrb_pin_mode,           MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "digital_write",    mrb_digital_write,      MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "_digital_read",    mrb_digital_read,       MRB_ARGS_REQ(1));

  // GPIO Alerts
  mrb_define_method(mrb, mrb_Denko_Board, "claim_alert",      mrb_claim_alert,        MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb_Denko_Board, "stop_alert",       mrb_stop_alert,         MRB_ARGS_REQ(1));
  mrb_define_method(mrb, mrb_Denko_Board, "get_alert",        mrb_get_alert,          MRB_ARGS_REQ(0));

  // PWM
  mrb_define_method(mrb, mrb_Denko_Board, "pwm_enable",       mrb_pwm_enable,         MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "pwm_set_polarity", mrb_pwm_set_polarity,   MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "pwm_set_period",   mrb_pwm_set_period,     MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "pwm_write",        mrb_pwm_set_duty,       MRB_ARGS_REQ(2));

  // SARADC
  mrb_define_method(mrb, mrb_Denko_Board, "_analog_read",     mrb_analog_read,        MRB_ARGS_REQ(1));

  // I2C
  mrb_define_method(mrb, mrb_Denko_Board, "i2c_setup",        mrb_i2c_setup,          MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "_i2c_write",       mrb_i2c_write,          MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "_i2c_read",        mrb_i2c_read,           MRB_ARGS_REQ(2));

  // Bit-bang I2C
  mrb_define_method(mrb, mrb_Denko_Board, "i2c_bb_setup",     mrb_i2c_bb_setup,       MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "_i2c_bb_search",   mrb_i2c_bb_search,      MRB_ARGS_REQ(2));
  mrb_define_method(mrb, mrb_Denko_Board, "_i2c_bb_read",     mrb_i2c_bb_read,        MRB_ARGS_REQ(4));
  mrb_define_method(mrb, mrb_Denko_Board, "_i2c_bb_write",    mrb_i2c_bb_write,       MRB_ARGS_REQ(4));

  // SPI
  mrb_define_method(mrb, mrb_Denko_Board, "_spi_transfer",    mrb_spi_xfer,           MRB_ARGS_REQ(4));
  mrb_define_method(mrb, mrb_Denko_Board, "spi_ws2812_write", mrb_spi_ws2812_write,   MRB_ARGS_REQ(2));

  // Bit-bang SPI
  mrb_define_method(mrb, mrb_Denko_Board, "_spi_bb_transfer", mrb_spi_bb_xfer,        MRB_ARGS_REQ(8));
}

void
mrb_mruby_denko_milkv_duo_gem_final(mrb_state* mrb) {
}
