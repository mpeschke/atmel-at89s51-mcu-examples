# atmel-at89s51-mcu-examples

Examples to program the Intel MCS-51 based Atmel's AT89S51 MCU (MicroController Unit).  

## Dependencies

You need sdcc compiler in order to build the libraries and examples in this repository. On Ubuntu, you can install sdcc by running the commands:  

>*\# apt install -y sdcc sdcc-ucsim*  

Optional components (sdcc documentation, avrdude to flash the firmware, and the MCU 8051 IDE for the sdcc compiler):  

>*\# apt install -y sdcc-doc avrdude mcu8051ide*  

## General Guidelines

It is possible to create a CMake-based set of files to automate the build process of the examples below. However, the build process is so simple that I'll leave it to be run manually on every example. This final build result is an Intel HEX file that can be flashed as the MCU's firmware.  

## Flashing the Firmware

There are many ways to program (flash) the AT89S51's firwmware. The most common is to wire an Arduino to the MCU as an ISP programmer (the *Serial Programming* as referred to in the AT89S51 documentation). Once properly wired, you can use avrdude to upload the HEX file, through the Arduino, into the AT89S51 flash memory. Example:  

>*$ cd src/*  

The -P parameter must be the USB port where your ISP programmer is connected to:  

>*$ avrdude -C ../conf/AT89S5x.conf -c stk500v1 -P /dev/ttyUSB0 -p 89s51 -b 19200*  

>*$ avrdude -C ../conf/AT89S5x.conf -c stk500v1 -P /dev/ttyUSB0 -p 89s51 -b 19200 -U flash:w:ex1-lcd-8bits.hex*  

# Example 1 - Interfacing the MCU with a HITACHI HD44780 LCD Controller Module (8-bit Data Registers)

The HITACHI HD44780 is a dot matrix liquid crystal display controller popular in the 1980s. Common display sizes are (columns x lines): 8x1, 16x2, 20x2 and 20x4, able to display up to 80 different characters (ASCII and Japanese Kana). Available modules usually offer 16 contacts, designed to easily connect with the Intel MCS-51 based MCU's XRAM interface.  

Source: https://en.wikipedia.org/wiki/Hitachi_HD44780_LCD_controller  

The pinout to work with this example, using 8 contacts, can be found here: https://upverter.com/design/mpeschke/6fdc961f2fc68cf1/  

To build this example:  

>*$ cd src/*  

Build the libraries' machine code objects:  

>*$ sdcc -c ../lib/hd44780.c*  
>*$ sdcc -c ../lib/mcs-51.c*  

Create the libraries' lib files:  

>*$ sdar -rc hd44780.lib hd44780.rel*  
>*$ sdar -rc mcs-51.lib mcs-51.rel*  

Build the example's machine code objects and link to the libraries' binaries:  

>*$ sdcc ex1-lcd-8bits.c mcs-51.lib hd44780.lib -L mcs-51.lib hd44780.lib*  

Create the Intel HEX file ready to be flashed into the MCU's firmware:  

>*$ packihx ex1-lcd-8bits.ihx > ex1-lcd-8bits.hex*  

# Example 2 - Interfacing the MCU with a HITACHI HD44780 LCD Controller Module (4-bit Data Registers)

The pinout to work with this example, using 4 contacts, can be found here: https://upverter.com/design/mpeschke/f663efbbfb30df67  

To build this example:  

>*$ cd src/*  

Build the libraries' machine code objects:  

>*$ sdcc -c ../lib/hd44780.c*  
>*$ sdcc -c ../lib/mcs-51.c*  

Create the libraries' lib files:  

>*$ sdar -rc hd44780.lib hd44780.rel*  
>*$ sdar -rc mcs-51.lib mcs-51.rel*  

Build the example's machine code objects and link to the libraries' binaries:  

>*$ sdcc ex2-lcd-4bits.c mcs-51.lib hd44780.lib -L mcs-51.lib hd44780.lib*  

Create the Intel HEX file ready to be flashed into the MCU's firmware:  

>*$ packihx ex2-lcd-4bits.ihx > ex2-lcd-4bits.hex*  

