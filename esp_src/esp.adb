with Interfaces.C;

package body ESP
is

   procedure Debug (S : String)
   is
      function Puts (S : String) return Interfaces.C.int with
         Import,
         Convention => C,
         External_Name => "puts";
      Unused_Result : Interfaces.C.int;
      C_String : String (1 .. S'Length + 1);
    begin
      C_String (1 .. S'Length) := S;
      C_String (C_String'Last) := Character'First;
      Unused_Result := Puts (C_String);
   end Debug;

end ESP;
