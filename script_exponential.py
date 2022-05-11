import math 
import struct
import numpy as np

def floatToBinary32(value):
    	binstr = ''.join(f'{c:0>8b}' for c in struct.pack('!f', value))
    	return binstr[0], binstr[1:9], binstr[9:]

# Driver Code
if __name__ == "__main__":

	start = -8
	end = 0
	step = 0.25
	
	index = 0
	
	# range for floats with np.arange()
	for val in np.arange(start * 10, end * 10, step * 10) / 10:

		# Function call to get
		# Sign, Exponent and
		# Mantissa Bit Strings.
		arg = val
		sign_bit, exp_str, mant_str = floatToBinary32(arg)

		# Final Floating point Representation.
		x_l = str(sign_bit) + exp_str + mant_str
		
		arg = math.exp(val)
		sign_bit, exp_str, mant_str = floatToBinary32(arg)
		y_l = str(sign_bit) + exp_str + mant_str
		
		arg = (math.exp(val + step) - math.exp(val)) / step
		sign_bit, exp_str, mant_str = floatToBinary32(arg)
		a = str(sign_bit) + exp_str + mant_str

		arg = math.exp(val) - ((math.exp(val + step) - math.exp(val)) / step) * val
		sign_bit, exp_str, mant_str = floatToBinary32(arg)
		b = str(sign_bit) + exp_str + mant_str # represents y_l - a * x_l

		# Printing the ieee 32 representation of x_l, a, and y_l - a * x_l.
		print("LUT[" + str(index) + "] = 96\'b" + x_l + a + b + ";")
		
		index = index + 1
