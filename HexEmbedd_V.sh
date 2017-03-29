# Builder for AVR embedded projects:

                ############ RELEASE DIRECTORY CLEANUP ############
                
if [ Release/ ]; then
rm -r Release/
fi

mkdir -m 755 Release &&
cd Release &&

                #################### VARIABLES ####################
                
CPU_FREQUENCY=1000000UL
                
#MCU_TARGET="at90s2313"
#MCU_TARGET="at90s2333"
#MCU_TARGET="at90s4414"
#MCU_TARGET="at90s4433"
#MCU_TARGET="at90s4434"
#MCU_TARGET="at90s8515"
#MCU_TARGET="at90s8535"
#MCU_TARGET="atmega128"
#MCU_TARGET="atmega1280"
#MCU_TARGET="atmega1281"
#MCU_TARGET="atmega1284p"
#MCU_TARGET="atmega16"
#MCU_TARGET="atmega163"
#MCU_TARGET="atmega164p"
#MCU_TARGET="atmega165"
#MCU_TARGET="atmega165p"
#MCU_TARGET="atmega168"
#MCU_TARGET="atmega169"
#MCU_TARGET="atmega169p"
#MCU_TARGET="atmega2560"
#MCU_TARGET="atmega2561"
#MCU_TARGET="atmega32"
#MCU_TARGET="atmega324p"
#MCU_TARGET="atmega325"
#MCU_TARGET="atmega3250"
MCU_TARGET="atmega328p"
#MCU_TARGET="atmega329"
#MCU_TARGET="atmega3290"
#MCU_TARGET="atmega32u4"
#MCU_TARGET="atmega48"
#MCU_TARGET="atmega64"
#MCU_TARGET="atmega640"
#MCU_TARGET="atmega644"
#MCU_TARGET="atmega644p"
#MCU_TARGET="atmega645"
#MCU_TARGET="atmega6450"
#MCU_TARGET="atmega649"
#MCU_TARGET="atmega6490"
#MCU_TARGET="atmega8"
#MCU_TARGET="atmega8515"
#MCU_TARGET="atmega8535"
#MCU_TARGET="atmega88"
#MCU_TARGET="attiny2313"
#MCU_TARGET="attiny24"
#MCU_TARGET="attiny25"
#MCU_TARGET="attiny26"
#MCU_TARGET="attiny261"
#MCU_TARGET="attiny44"
#MCU_TARGET="attiny45"
#MCU_TARGET="attiny461"
#MCU_TARGET="attiny84"
#MCU_TARGET="attiny85"
#MCU_TARGET="attiny861"


             ##################   WORKING DIRECTORY   ####################

WORKING_DIRECTORY=${PWD}'/'
RELEASE_NAME=${PWD##*/}
RELEASE_DIRECTORY_PATH=$WORKING_DIRECTORY"Release/"


             ####################   SOURCE FILES   #######################

find . -type f -not -path "*cmake-build-debug*" -not -path "*private*" -name '*.c' > file_search
mv file_search Release/
cd Release/

while read line; do
    FILE_NAME=$(basename $WORKING_DIRECTORY${line:1} .c)
    DIR_NAME=${line%/*}
    FULL_DIR_NAME=$WORKING_DIRECTORY${DIR_NAME:2}'/'
    avr-gcc -Wall -Os -fpack-struct -fshort-enums -ffunction-sections -fdata-sections -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$MCU_TARGET -DF_CPU=$CPU_FREQUENCY -MMD -MP -MF$RELEASE_DIRECTORY_PATH$FILE_NAME.d -MT$RELEASE_DIRECTORY_PATH$FILE_NAME.o -c -o $RELEASE_DIRECTORY_PATH$FILE_NAME.o $FULL_DIR_NAME$FILE_NAME.c
done <file_search
rm file_search


            ###############   COMPILE OBJECTS COMMANDS   ##################

avr-gcc -Wl,-Map,$RELEASE_NAME.map -mmcu=$MCU_TARGET -o $RELEASE_NAME.elf $RELEASE_DIRECTORY_PATH*.o
avr-objdump -h -S $RELEASE_NAME.elf > $RELEASE_NAME.lst &&
avr-objcopy -R .eeprom -R .fuse -R .lock -R .signature -O ihex $RELEASE_NAME.elf $RELEASE_NAME.hex &&
avr-objcopy -j .eeprom --no-change-warnings --change-section-lma .eeprom=0 -O ihex $RELEASE_NAME.elf  $RELEASE_NAME.eep &&
avr-size --format=avr --mcu=$MCU_TARGET $RELEASE_NAME.elf
