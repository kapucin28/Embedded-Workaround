# Builder for AVR embedded projects:

                ############ CLEANUP ############
                
if [ Release/ ]; then
rm -r Release/
fi

mkdir -m 755 Release &&
cd Release &&

                ############ VARIABLES ############
                
CPU_FREQUENCY=1000000UL
                
#MCU_TARGET     = "at90s2313"
#MCU_TARGET     = "at90s2333"
#MCU_TARGET     = "at90s4414"
#MCU_TARGET     = "at90s4433"
#MCU_TARGET     = "at90s4434"
#MCU_TARGET     = "at90s8515"
#MCU_TARGET     = "at90s8535"
#MCU_TARGET     = "atmega128"
#MCU_TARGET     = "atmega1280"
#MCU_TARGET     = "atmega1281"
#MCU_TARGET     = "atmega1284p"
#MCU_TARGET     = "atmega16"
#MCU_TARGET     = "atmega163"
#MCU_TARGET     = "atmega164p"
#MCU_TARGET     = "atmega165"
#MCU_TARGET     = "atmega165p"
#MCU_TARGET     = "atmega168"
#MCU_TARGET     = "atmega169"
#MCU_TARGET     = "atmega169p"
#MCU_TARGET     = "atmega2560"
#MCU_TARGET     = "atmega2561"
#MCU_TARGET     = "atmega32"
#MCU_TARGET     = "atmega324p"
#MCU_TARGET     = "atmega325"
#MCU_TARGET     = "atmega3250"
MCU_TARGET      = "atmega328p"
#MCU_TARGET     = "atmega329"
#MCU_TARGET     = "atmega3290"
#MCU_TARGET     = "atmega32u4"
#MCU_TARGET     = "atmega48"
#MCU_TARGET     = "atmega64"
#MCU_TARGET     = "atmega640"
#MCU_TARGET     = "atmega644"
#MCU_TARGET     = "atmega644p"
#MCU_TARGET     = "atmega645"
#MCU_TARGET     = "atmega6450"
#MCU_TARGET     = "atmega649"
#MCU_TARGET     = "atmega6490"
#MCU_TARGET     = "atmega8"
#MCU_TARGET     = "atmega8515"
#MCU_TARGET     = "atmega8535"
#MCU_TARGET     = "atmega88"
#MCU_TARGET     = "attiny2313"
#MCU_TARGET     = "attiny24"
#MCU_TARGET     = "attiny25"
#MCU_TARGET     = "attiny26"
#MCU_TARGET     = "attiny261"
#MCU_TARGET     = "attiny44"
#MCU_TARGET     = "attiny45"
#MCU_TARGET     = "attiny461"
#MCU_TARGET     = "attiny84"
#MCU_TARGET     = "attiny85"
#MCU_TARGET     = "attiny861"

PROJECT_NAME="Main"
EXTERN_FILE1="InitLCD"
EXTERN_FILE2="WritingInstructions"
EXTERN_FILE3="WritingChar"
EXTERN_FILE4="WritingString"
EXTERN_FILE5="WritingToLCD"

BUILD_PATH="/home/CLionProjects/MicrocontrollerProject/main/"
EXTERN_BUILD_PATH="/home/CLionProjects/MicrocontrollerProject/externFiles/"
RELEASE_PROJECT="$BUILD_PATH$PROJECT_NAME"
RELEASE_DIRECTORY_PATH="/home/CLionProjects/MicrocontrollerProject/Release/"


            ####################	COMMANDS	####################

avr-gcc -Wall -Os -fpack-struct -fshort-enums -ffunction-sections -fdata-sections -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$MCU_TARGET -DF_CPU=$CPU_FREQUENCY -MMD -MP -MF$RELEASE_DIRECTORY_PATH$PROJECT_NAME.d -MT$RELEASE_DIRECTORY_PATH$PROJECT_NAME.o -c -o $RELEASE_DIRECTORY_PATH$PROJECT_NAME.o $RELEASE_PROJECT.c &&
avr-gcc -Wall -Os -fpack-struct -fshort-enums -ffunction-sections -fdata-sections -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$MCU_TARGET -DF_CPU=$CPU_FREQUENCY -MMD -MP -MF$RELEASE_DIRECTORY_PATH$EXTERN_FILE1.d -MT$RELEASE_DIRECTORY_PATH$EXTERN_FILE1.o -c -o $RELEASE_DIRECTORY_PATH$EXTERN_FILE1.o $EXTERN_BUILD_PATH$EXTERN_FILE1.c &&
avr-gcc -Wall -Os -fpack-struct -fshort-enums -ffunction-sections -fdata-sections -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$MCU_TARGET -DF_CPU=$CPU_FREQUENCY -MMD -MP -MF$RELEASE_DIRECTORY_PATH$EXTERN_FILE2.d -MT$RELEASE_DIRECTORY_PATH$EXTERN_FILE2.o -c -o $RELEASE_DIRECTORY_PATH$EXTERN_FILE2.o $EXTERN_BUILD_PATH$EXTERN_FILE2.c &&
avr-gcc -Wall -Os -fpack-struct -fshort-enums -ffunction-sections -fdata-sections -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$MCU_TARGET -DF_CPU=$CPU_FREQUENCY -MMD -MP -MF$RELEASE_DIRECTORY_PATH$EXTERN_FILE3.d -MT$RELEASE_DIRECTORY_PATH$EXTERN_FILE3.o -c -o $RELEASE_DIRECTORY_PATH$EXTERN_FILE3.o $EXTERN_BUILD_PATH$EXTERN_FILE3.c &&
avr-gcc -Wall -Os -fpack-struct -fshort-enums -ffunction-sections -fdata-sections -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$MCU_TARGET -DF_CPU=$CPU_FREQUENCY -MMD -MP -MF$RELEASE_DIRECTORY_PATH$EXTERN_FILE4.d -MT$RELEASE_DIRECTORY_PATH$EXTERN_FILE4.o -c -o $RELEASE_DIRECTORY_PATH$EXTERN_FILE4.o $EXTERN_BUILD_PATH$EXTERN_FILE4.c &&
avr-gcc -Wall -Os -fpack-struct -fshort-enums -ffunction-sections -fdata-sections -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=$MCU_TARGET -DF_CPU=$CPU_FREQUENCY -MMD -MP -MF$RELEASE_DIRECTORY_PATH$EXTERN_FILE5.d -MT$RELEASE_DIRECTORY_PATH$EXTERN_FILE5.o -c -o $RELEASE_DIRECTORY_PATH$EXTERN_FILE5.o $EXTERN_BUILD_PATH$EXTERN_FILE5.c &&
avr-gcc -Wl,-Map,$PROJECT_NAME.map -mmcu=$MCU_TARGET -o $PROJECT_NAME.elf $RELEASE_DIRECTORY_PATH$PROJECT_NAME.o $RELEASE_DIRECTORY_PATH$EXTERN_FILE1.o $RELEASE_DIRECTORY_PATH$EXTERN_FILE2.o $RELEASE_DIRECTORY_PATH$EXTERN_FILE3.o $RELEASE_DIRECTORY_PATH$EXTERN_FILE4.o $RELEASE_DIRECTORY_PATH$EXTERN_FILE5.o &&
avr-objdump -h -S $PROJECT_NAME.elf > $PROJECT_NAME.lss &&
avr-objcopy -R .eeprom -R .fuse -R .lock -R .signature -O ihex $PROJECT_NAME.elf $PROJECT_NAME.hex &&
avr-objcopy -j .eeprom --no-change-warnings --change-section-lma .eeprom=0 -O ihex $PROJECT_NAME.elf  $PROJECT_NAME.eep &&
avr-size --format=avr --mcu=$MCU_TARGET $PROJECT_NAME.elf
