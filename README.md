# Embedded-Workaround
  Bash script for embedded C programming, that allows you to write code with your favorite IDE without the need of a plug-in!
  
  This script can be run from the integrated terminals within CLion IDE or Visual Studio Code IDE or any other IDE.
  The script acts like a crawler that goes through all the directories that are in the project and then it builds the Release directory.
  
  For step-by-step instructions follow these links:
  

  This script targets AVR microcontrollers so make sure you install first the following packages from the terminal:
   - avrdude,
   - avr-libc,
   - binutils-avr,
   - gcc-avr.
Complete command:
   sudo apt-get install avrdude avr-libc binutils-avr gcc-avr  

  The .sh will do the following:
   - compile c files in the project,
   - create the .map file,
   - create the .lst file,
   - create the .o files,
   - create the .elf file,
   - create the .hex file (that can be used to flash into a microcontroller).
