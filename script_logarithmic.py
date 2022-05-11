import math 
import struct
import numpy as np

def floatToBinary32(value):
    	binstr = ''.join(f'{c:0>8b}' for c in struct.pack('!f', value))
    	return binstr

# Driver Code
if __name__ == "__main__":

	q = 9
	start = 1
	end = 2 * (1 - 0.5**(23 - q + 1))
	step = 0.5**(23 - q) 
	
	index = 0
	
	# range for floats with np.arange()
	for val in np.arange(start * 10, (end + step) * 10, step * 10) / 10:

		# Function call to get
		# Sign, Exponent and
		# Mantissa Bit Strings.
		arg = math.log2(val)
		
		# Final Floating point Representation.
		log2_val = floatToBinary32(arg)
				
		# Printing the ieee 32 representation of log2_val
		print("LUT[" + str(index) + "] = 32\'b" + log2_val + ";")
		
		index = index + 1
