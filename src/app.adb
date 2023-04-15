with ESP;
with ESP.Error;
with ESP.Drivers.GPIO;
with ESP.Drivers.LED_Strip;
with Interfaces;

package body App
is
   package GPIO renames ESP.Drivers.GPIO;

   procedure VTaskDelay (Ticks : Natural) with
      Import,
      Convention => C,
      External_Name => "vTaskDelay";

   procedure Main
   is
      use type GPIO.Level;
      use type Interfaces.Unsigned_32;
      use type ESP.Error.ESP_Error;
      Error : ESP.Error.ESP_Error;
      LED_Config : aliased ESP.Drivers.LED_Strip.LED_Config :=
         (GPIO_Num => ESP.Drivers.GPIO.GPIO_8,
          Max_Leds => 1,
          Format   => ESP.Drivers.LED_Strip.GRB,
          Model    => ESP.Drivers.LED_Strip.WS2812,
          Flags    => ESP.Drivers.LED_Strip.LED_Config_Flags'(Invert_Out => False));
      RMT_Config : aliased ESP.Drivers.LED_Strip.RMT_Config :=
         (Clock_Source      => 0,
          Resolution        => 10 * 1000 * 1000,
          Mem_Block_Symbols => 0,
          Flags             => ESP.Drivers.LED_Strip.RMT_Config_Flags'(With_DMA => False));
      Strip : ESP.Drivers.LED_Strip.Strip;
      Led_On : Boolean := False;
   begin
      loop
         Error := ESP.Drivers.LED_Strip.New_RMT_Device (LED_Config'Access, RMT_Config'Access, Strip);
         ESP.Debug ("New_RMT_Device: " & Error'Image);
         if Error = ESP.Error.OK then
            Error := ESP.Drivers.LED_Strip.Clear (Strip);
            ESP.Debug ("Clear: " & Error'Image);
            loop
               if not Led_On then
                  Error := ESP.Drivers.LED_Strip.Set_Pixel (Strip, 0, 16, 16, 16);
                  ESP.Debug ("Set_Pixel: " & Error'Image);
                  Error := ESP.Drivers.LED_Strip.Refresh (Strip);
                  ESP.Debug ("Refresh: " & Error'Image);
               else
                  Error := ESP.Drivers.LED_Strip.Clear (Strip);
                  ESP.Debug ("Clear: " & Error'Image);
               end if;
               Led_On := not Led_On;
               VTaskDelay (50);
            end loop;
         end if;
         vTaskDelay (50);
      end loop;
   end Main;

end App;
