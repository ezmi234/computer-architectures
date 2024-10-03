# Computer Architecture

### Data types
- **Byte:** 8 bits  
- **Half Words** 16 bits 
- **Words** 32 bits
- **Double Words** 64 bits

### Special 


## MIPS instructions

### General 3 operand format:
`op    dest,src1,src2`  dest, src1 and src2 are registers  

**Example:**
- `add    a,b,c`   -->  a = b + c
- `addi  a,b,12`  -->  a = b + 12 

The `i` in in `addi` is for immediate. Same for `sub` and `subi` 


### Data operations:
- **Arithmetic** add, sub, addi, mult, div;
- **Logical** and, or ...;

### Data transfer:
- **Load** lw (load word);
- **Store** sw.

### Sequencing:
- **Branch** conditional;
- **Jump** unconditional.

## Registers:
R0 --> R31 each is 32 bits wide and value for instructions must come from registers

### Some are special:
- R0 is always 0
- R29/R31 are used for function calls
- PC (Program counter) current instruction

## Memory:
to compute operations data types should be load in registers
- Memory is large 1-dimension array
- Each location is one byte (8 bits)
- A memory address indexes into the array

