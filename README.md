# addsub-base
Yang Wenting          wy77
Liu Mengqi            ml607
 

Design Description

In this project,we built a 32-bit ALU with addition and subtraction,which are supported by CSA, MUX and logic gates. Below are the basic modules or functions of our ALU and introductions of how we realized them.

mux_32bit

We first designed a mux_2_1. Then we expanded the number of mux_2_1s, for example, a mux_4bits is made by 4 mux_2_1s and each mux_2_1 is responsible for selecting each bit based on the same selecting signal. In this way, we finally built mux_32bit. Later, we would use it to select whether to output data_operandB or the compliment of data_operandB. 


MUX_8bit
We use this 8:1 mux to decide which operation (among add, sub, shift, and, or) to take. The input is ctrl_opcode, and it should give the correspondant output.

csa_adder_32bits

We first designed a full_adder and used 4 full_adders to design a 4-bit RCA adder. Then, we used 3 4-bit RCA adders and 5 mux_2_1s to design a 8-bit CSA,including 8-bit output and one carry out. Next, we used 3 8-bit CSAs and 9 mux_2_1s to design a 16-bit CSA, including 16-bit output and one carry out. Later, we used 3 16-bit CSAs and 17 mux_2_1s to design a 32-bit CSA, including 32-bit output and one carry out. 


Addition and Subtraction

We used a mux_32bit to select whether to do addition or subtraction.The two 32-bit inputs were operand B and
the negation of operand B, the select input was 00000(addtion) or 00001(subtraction), which was also the carry in of the csa_adder_32bits.

AND and OR
We built bitwise AND and OR functions for two 32-bit inputs by performing bitwise and gate and or gate respectively.(from the module andor)

SLL and SRA
We constructed 32-bit barrel shifter with SLL (Logical Left Shift) and SRA (Arithmetic Right Shift) in the modules sll and sra. In sll, we used five layers of muxes, the first layer decides whether to shift by 1 bit, the second layer shifts 2 bits, the third shifts 4 bits, the fourth shifts 8 bits, and the fifth shifts 16 bits, all together they can perform 0 - 32 bits logical left shift, controlled by ctrl_shiftamt. The sra is constructed based on sll, we first reverse the bitwise order of the input, then put it into sll, when sll receives an input from sra, it changes from "adding 0 to the end" to "adding sign bit to the end", then we reverse the output of sll, that is the result of sra. We combine these two shifting functions in the module datashift; ctrl_ALUopcode can decide which shifting behavior should be applied.

isNotEqual and isLessThan
We included isNotEqual and isLessThan output in the alu.v, by performing subtraction on two input numbers and comparing their sign bits.

Overflow
We used the definition XOR(CO,CI) to represent overflow. The wire cout is the 32_bit carry out. Then, to get the 32_bit carry in, we used a xor logic gate to get the sum of data_operandA[31] and comp_B[31]. If the sum equals to data_result[31], it means 32_bit carry in is 0, otherwise it is 1. Therefore, we used another xor logic gate to get the 32_bit carry in.
Finally, we could use a xor gate to obtain the final overflow.



