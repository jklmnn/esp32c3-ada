#![no_std]

use core::fmt::Write;
use esp32c3_hal::{pac, prelude::*, RtcCntl, Serial, Timer};
use nb::block;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}

#[link(name = "app", kind = "static")]
extern "C" {
    fn appinit();
}

pub fn ada_main() -> ! {
    let peripherals = pac::Peripherals::take().unwrap();
    let rtccntl = RtcCntl::new(peripherals.RTCCNTL);
    let mut timer0 = Timer::new(peripherals.TIMG0);
    let mut serial0 = Serial::new(peripherals.UART0).unwrap();

    // Disable watchdogs (they otherwise reset the SoC)
    rtccntl.set_super_wdt_enable(false);
    rtccntl.set_wdt_enable(false);
    timer0.disable();

    // Initialize the timer with an interval of 1 second
    // TODO: Switch to coherent units.
    timer0.start(10_000_000u64);
    block!(timer0.wait()).unwrap();
    writeln!(serial0, "Calling Ada...").unwrap();
    unsafe {
        appinit();
    }
    writeln!(serial0, "Done!").unwrap();

    loop {}
}
