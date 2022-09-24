with ESP.Error;

package ESP.Drivers.GPIO
is

   type Num is (GPIO_NC, GPIO_0, GPIO_1, GPIO_2, GPIO_3, GPIO_4, GPIO_5, GPIO_6,
                GPIO_7, GPIO_8, GPIO_9, GPIO_10, GPIO_11, GPIO_12, GPIO_13, GPIO_14,
                GPIO_15, GPIO_16, GPIO_17, GPIO_18, GPIO_19, GPIO_20, GPIO_21) with
      Size => 32;

   for Num use (GPIO_NC => -1,
                GPIO_0  =>  0,
                GPIO_1  =>  1,
                GPIO_2  =>  2,
                GPIO_3  =>  3,
                GPIO_4  =>  4,
                GPIO_5  =>  5,
                GPIO_6  =>  6,
                GPIO_7  =>  7,
                GPIO_8  =>  8,
                GPIO_9  =>  9,
                GPIO_10 => 10,
                GPIO_11 => 11,
                GPIO_12 => 12,
                GPIO_13 => 13,
                GPIO_14 => 14,
                GPIO_15 => 15,
                GPIO_16 => 16,
                GPIO_17 => 17,
                GPIO_18 => 18,
                GPIO_19 => 19,
                GPIO_20 => 20,
                GPIO_21 => 21);

   type Mode is (DISABLE, INPUT, OUTPUT, INPUT_OUTPUT, OUTPUT_OD, INPUT_OUTPUT_OD);

   for Mode use (DISABLE         => 0,
                 INPUT           => 1,
                 OUTPUT          => 2,
                 INPUT_OUTPUT    => 3,
                 OUTPUT_OD       => 6,
                 INPUT_OUTPUT_OD => 7);

   type Level is (Low, High) with Size => 32;

   for Level use (Low => 0, High => 1);

   function "not" (L : Level) return Level is
      (case L is
         when Low => High,
         when High => Low);

   function Reset_Pin (N : Num) return ESP.Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "gpio_reset_pin";

   function Set_Direction (N : Num; M : Mode) return ESP.Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "gpio_set_direction";

   function Set_Level (N : Num; L : Level) return ESP.Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "gpio_set_level";

   function Get_Level (N : Num) return Level with
      Import,
      Convention => C,
      External_Name => "gpio_get_level";

end ESP.Drivers.GPIO;
