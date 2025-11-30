

#!/usr/bin/env python3
import os
import mmap
import time

import struct

# Constants from your IP
IP_BASE_ADDR = 0x41200000  # AXI GPIO base
REG_SIZE = 0x1000          # Map 4KB (enough for AXI GPIO)
GPIO_DATA_OFFSET = 0x0      # Data register offset
OUTPUT_FILE = "trng_output2.txt"
# Open /dev/mem
fd = os.open("/dev/mem", os.O_RDWR | os.O_SYNC)

# Memory-map the AXI GPIO region
mem = mmap.mmap(fd, REG_SIZE, mmap.MAP_SHARED, mmap.PROT_READ | mmap.PROT_WRITE, offset=IP_BASE_ADDR)

# Function to read 32-bit register
def read_reg(offset):
    mem.seek(offset)
    data = mem.read(4)
    return struct.unpack("<I", data)[0]

with open(OUTPUT_FILE, "w") as f:
    for _ in range(3000000):    # Read the GPIO data register
        gpio_value = read_reg(GPIO_DATA_OFFSET)
        line = f"{gpio_value:02X}\n"
        f.write(line)  # write to file
        print(f"TRNG Value: 0x{gpio_value:02X} ({gpio_value})")
        time.sleep(0.000001) 

# Cleanup
mem.close()
os.close(fd)
