import os
import time
import crypt
import random
import sys

# Seed characters used in mooproxy
SEEDCHARS = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

def generate_salt():
    """Generate a salt similar to mooproxy's logic."""
    pid = os.getpid()
    t = int(time.time())
    tv_usec1 = random.randint(0, 999999)  # Simulate gettimeofday() before prompt
    tv_usec2 = random.randint(0, 999999)  # Simulate gettimeofday() after prompt

    # Construct salt based on mooproxy's method
    salt = [
        "$1$",  # MD5 prefix
        SEEDCHARS[(pid // 64) % 64], SEEDCHARS[pid % 64],  # Bits 47..36: PID
        SEEDCHARS[(t // 64) % 64], SEEDCHARS[t % 64],  # Bits 35..24: Time()
        SEEDCHARS[(tv_usec1 // 64) % 64], SEEDCHARS[tv_usec1 % 64],  # Bits 23..12: tv_usec before prompt
        SEEDCHARS[(tv_usec2 // 64) % 64], SEEDCHARS[tv_usec2 % 64],  # Bits 11..0: tv_usec after prompt
    ]

    return "".join(salt)

def generate_md5_hash(password):
    """Generate the mooproxy-compatible MD5 hash from a password."""
    salt = generate_salt()
    return crypt.crypt(password, salt)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python generate_mooproxy_hash.py <password>")
        sys.exit(1)

    password = sys.argv[1]
    hash_result = generate_md5_hash(password)

    print("{}".format(hash_result))  # Fixed for Python 3.5

    if password == "":
        print("Note: This is a hash of an empty string; it will be refused by mooproxy.")
