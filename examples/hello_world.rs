#![no_std]
#![no_main]

use esp32c_rt::entry;
#[allow(unused_imports)]
use panic_halt;

use esp32c3_ada::ada_main;

#[entry]
fn main() -> ! {
    ada_main();
}
