javac ./src/emulator/*.java -d ./build
jar cfe ./bin/emulator.jar EaterEmulator -C ./build .
java -jar ./bin/emulator.jar