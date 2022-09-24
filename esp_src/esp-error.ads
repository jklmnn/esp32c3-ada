with Interfaces.C;

package ESP.Error
is

   type ESP_Error is new Interfaces.C.int;

   OK   : constant ESP_Error := 0;
   FAIL : constant ESP_Error := -1;

   NO_MEM           : constant ESP_Error := 16#101#;
   INVALID_ARG      : constant ESP_Error := 16#102#;
   INVALID_STATE    : constant ESP_Error := 16#103#;
   INVALID_SIZE     : constant ESP_Error := 16#104#;
   NOT_FOUND        : constant ESP_Error := 16#105#;
   NOT_SUPPORTED    : constant ESP_Error := 16#106#;
   TIMEOUT          : constant ESP_Error := 16#107#;
   INVALID_RESPONSE : constant ESP_Error := 16#108#;
   INVALID_CRC      : constant ESP_Error := 16#109#;
   INVALID_VERSION  : constant ESP_Error := 16#10A#;
   INVALID_MAC      : constant ESP_Error := 16#10B#;
   NOT_FINISHED     : constant ESP_Error := 16#10C#;

   WIFI_BASE      : constant ESP_Error := 16#3000#;
   MESH_BASE      : constant ESP_Error := 16#4000#;
   FLASH_BASE     : constant ESP_Error := 16#5000#;
   HW_CRYPTO_BASE : constant ESP_Error := 16#C000#;
   MEMPROT_BASE   : constant ESP_Error := 16#D000#;

end ESP.Error;
