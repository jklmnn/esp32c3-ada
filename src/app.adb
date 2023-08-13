with Ada.Text_IO;
with ESP.Error;
with ESP.Drivers.GPIO;
with ESP.Drivers.LED_Strip;
with HAL.GPIO;
with Interfaces;

procedure App
is
   procedure VTaskDelay (Ticks : Natural) with
      Import,
      Convention => C,
      External_Name => "vTaskDelay";

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
   Led_Pin : ESP.Drivers.GPIO.GPIO_Pin := ESP.Drivers.GPIO.Create (ESP.Drivers.GPIO.GPIO_9, HAL.GPIO.Output);
begin
   Led_Pin.Set;
   loop
      Error := ESP.Drivers.LED_Strip.New_RMT_Device (LED_Config'Access, RMT_Config'Access, Strip);
      Ada.Text_IO.Put_Line ("New_RMT_Device: " & Error'Image);
      if Error = ESP.Error.OK then
         Error := ESP.Drivers.LED_Strip.Clear (Strip);
         Ada.Text_IO.Put_Line ("Clear: " & Error'Image);
         loop
            if not Led_On then
               Led_Pin.Clear;
               Error := ESP.Drivers.LED_Strip.Set_Pixel (Strip, 0, 16, 16, 16);
               Ada.Text_IO.Put_Line ("Set_Pixel: " & Error'Image);
               Error := ESP.Drivers.LED_Strip.Refresh (Strip);
               Ada.Text_IO.Put_Line ("Refresh: " & Error'Image);
            else
               Led_Pin.Set;
               Error := ESP.Drivers.LED_Strip.Clear (Strip);
               Ada.Text_IO.Put_Line ("Clear: " & Error'Image);
            end if;
            Led_On := not Led_On;
            VTaskDelay (50);
         end loop;
      end if;
      vTaskDelay (50);
   end loop;
end App;
