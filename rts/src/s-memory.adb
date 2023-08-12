package body System.Memory
is

   function Os_Malloc (Size : size_t) return System.Address with
      Import,
      Convention => C,
      External_Name => "malloc";

   function Alloc (Size : size_t) return System.Address renames Os_Malloc;

end System.Memory;
