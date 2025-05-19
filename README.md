# Simple Computer Feistel Cipher Implementation

Project Overview
----------------

This project implements a simplified Feistel cipher for text encryption on a Simple Computer architecture as part of ECE 2544: Fundamentals of Digital Systems. The implementation is written in assembly language for a single-cycle, load-store CPU, and demonstrates fundamental principles of cryptography and assembly programming.

What is a Feistel Cipher?
------------------
A Feistel cipher is a symmetric block cipher structure that alternates between substitutions and permutations. Conceived in the 1970s, this structure forms the basis for many significant encryption algorithms including the Data Encryption Standard (DES).
The key features of a Feistel cipher include:

  Processing data in fixed-size blocks
  Dividing each block into two halves (left and right)
  Multiple rounds of encryption using a round function
  Swapping the halves after each round
  Using different subkeys for each round derived from a master key

Implementation Details
--------------------

Input text is encoded in ASCII and packed two characters per 16-bit data block
The first character is stored in the upper byte, the second in the lower byte
For strings with an odd number of characters, the final byte is zero-filled

Encryption Process
-------------------

The implementation follows these steps:

Store the student ID in BCD format at memory location 0x00
Read the input data array location and length from memory locations 0x01 and 0x02
Process each 16-bit data block through 8 rounds of the Feistel encryption
Store the encrypted results in memory locations 0x03-0x06

Round Function
----------------
Each round of encryption consists of:

Dividing the data block into left (bits 15-8) and right (bits 7-0) halves
Applying the round function to the right half:

XOR with the round key (middle 8 bits of the key)
Bit permutation according to a predefined pattern


XOR of the result with the left half
The original right half becomes the new left half
After 8 rounds, the halves are swapped one final time

Key Scheduling
--------------------

A 16-bit master key is used to derive 8 round keys
For the first round, the middle 8 bits of the key are used
For each subsequent round, a circular right shift is performed on the key, and the middle 8 bits are extracted

Bit Permutation
--------------------------
The permutation step of the round function rearranges the bit positions according to the following mapping:

Input bits [7,6,5,4,3,2,1,0] → Output bits [0,4,3,6,2,7,5,1]

Technical Implementation
-------------------------
The assembly code is organized into several key sections:

Initialization and setup
Memory configuration for constants and bitmasks
Key generation and storage
Student ID storage
Main encryption process (including the 8 rounds)
Result storage
Validation and display logic

System Requirements
-----------------------

Quartus Prime Lite Edition software
DE10-Lite Board for hardware implementation
Simple Computer architecture 

Usage
------------------------------

Assemble the source code using an appropriate assembler for the Simple Computer architecture
Modify instruction.txt to contain the generated machine code
Edit data.txt to store the input data arrays according to the requirements
Compile the project and program the DE10-Lite board
Use the switches to view different register values and verify proper encryption

Testing
----------------
The implementation was tested with multiple datasets, including:

Strings of various lengths (3-8 characters)
Different keys and array starting locations
Edge cases like odd-length strings

Conclusion
----------------------
This project demonstrates the implementation of a fundamental cryptographic algorithm in assembly language, showcasing both the principles of the Feistel cipher structure and low-level programming techniques for a simple computer architecture.
