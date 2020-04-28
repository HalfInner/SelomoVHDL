# Selomo VHDL
Sequential Logic Modulo VHDL. Create finite state machine which do operation like `-1`, `+1`, `shift right`, `stop` in synchronous mode. Were the output is *Is dividable by  2?* This reposiotory allows you to send single command by UART and check the status. The veryfing scripts is included 

## Overview

 * `-1` - substract one
 * `+1` - add one
 * `shift right` - shift right the value
 * `stop` - stay in same transition
 
Each value is represented by 12 -  states starting from zero to eleven. Operation are not base on value but on transitions. When you do `-1` you simple transit into `ELEVENTH`, thus no value is store. 

## Getting Started

### Installing
  * clone the repo
  * import into Isim tool
  * configure pins 
    * UART RX
    * UART Led
    * State Led
    * Reset
    * CLK 
  * configure FPGA / install on board - Tested on ElbertV2 Board
  * communicate with python script
### Example of usage

```python
from enum import Enum
from serial import Serial

class Command(Enum):
    STOP = 0
    SUBSTRACT_ONE = 1
    ADD_ONE = 2
    SHIFT_RIGHT = 3 

def getByteCommand(cmd : Command):
    return { 
    	Command.STOP : b'\x00',
        Command.SUBSTRACT_ONE : b'\x01',
        Command.ADD_ONE : b'\x02',
        Command.SHIFT_RIGHT : b'\x03',
    }[cmd]

def operate(value, mod, cmd : Command):
    return {
        Command.STOP : value % mod,
        Command.SUBSTRACT_ONE : (value - 1) % mod,
        Command.ADD_ONE : (value + 1) % mod,
        Command.SHIFT_RIGHT : (value >> 1) % mod,
    }[cmd]
    
def printAsHex(byte_array):
    print(' '.join('{:02x}'.format(byte) for byte in byte_array))


modulo = 12 # Hardcoded on FPGA
value = 0   # Hardcoded on FPGA
with Serial(port='/dev/ttyUSB0', baudrate=9600) as uart:
    while True:
        try:
            raw_cmd = input('Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: ')
            cmd = Command(int(raw_cmd))
        except Exception as e:
            print(e)
            cmd = Command.STOP
        
        uart.write(getByteCommand(cmd))
        value = operate(value, modulo, cmd)
        print('Val={}  LedLight={}'.format(value, (value % 2) == 0))

```

Example usage:
	*before running the script **reset** the the FPGA by "RESET" button*

```bash
halfsinner@ubuntu:~/Programming/SelomoVHDL$ sudo python3.7  ~/Programming/Utils/uart_second.py
Val: 0  Expected Led=True
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 0
Val: 0  Expected Led=True
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 2
Val: 1  Expected Led=False
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 2
Val: 2  Expected Led=True
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 2
Val: 3  Expected Led=False
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 2
Val: 4  Expected Led=True
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 2
Val: 5  Expected Led=False
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 3
Val: 2  Expected Led=True
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 1
Val: 1  Expected Led=False
Choose operation: [0->nop, 1->-1, 2->+1, 3->shift_r]: 1
Val: 0  Expected Led=True
```

## Running the tests

Two test benches are included
	* TEST_SELOMO - simulates the state machine mechanism
	* TEST_SELOMO_UI - simulates the example of communication via UART

## Author

* **Kajetan Brzuszczak** - *Submitted* - [HalfInner](https://github.com/HalfInner/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details