with System;
with Interfaces;
with ESP.Error;
with ESP.Drivers.GPIO;

package ESP.Drivers.LED_Strip
is

   type Strip is new System.Address;

   type LED_Config is record
      GPIO_Num : GPIO.Num;
      Max_Leds : Interfaces.Unsigned_32;
   end record;

   type RMT_Config is record
      Resolution : Interfaces.Unsigned_32;
   end record;

   function New_RMT_Device (L :     access LED_Config;
                            R :     access RMT_Config;
                            S : out Strip) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_new_rmt_device";

   function Set_Pixel (S     : Strip;
                       Index : Interfaces.Unsigned_32;
                       Red   : Interfaces.Unsigned_32;
                       Green : Interfaces.Unsigned_32;
                       Blue  : Interfaces.Unsigned_32) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_set_pixel";


   function Refresh (S : Strip) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_refresh";

   function Clear (S : Strip) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_clear";

   function Del (S : Strip) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_del";

end ESP.Drivers.LED_Strip;
