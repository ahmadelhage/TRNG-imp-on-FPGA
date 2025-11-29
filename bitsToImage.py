#!/usr/bin/env python3
import argparse
import math
from PIL import Image

def bitsToImage(
    source,
    dest
):
    # Read bits
    with open(source, "r") as f:
        data = f.read()

    bits = [c for c in data if c in ("0", "1")]
    n = len(bits)

    print(f"Read {n} bits")

    # Use 16:9 aspect ratio
    width = int(math.sqrt(n * (16/9)))
    height = int(width * 9 / 16)

    if width * height < n:
        height = math.ceil(n / width)

    print(f"Creating image of size {width}x{height}")

    # Create image
    img = Image.new("L", (width, height))
    pixels = img.load()

    for i, bit in enumerate(bits):
        x = i % width
        y = i // width
        pixels[x, y] = 255 if bit == "1" else 0

    img.save(dest)
    print(f"Saved image to {dest}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Convert a file of ASCII bits (0/1) into a grayscale image."
    )
    parser.add_argument("source", help="Input file containing ASCII 0/1 characters")
    parser.add_argument("destination", help="Output image file (e.g., output.png)")
    
    args = parser.parse_args()
    
    bitsToImage(
        source=args.source,
        dest=args.destination
    )
