package body System.Machine_Reset
is

   procedure OS_Abort with
      Import,
      Convention => C,
      External_Name => "abort",
      No_Return;

   procedure Stop
   is
   begin
      OS_Abort;
   end Stop;

end System.Machine_Reset;
