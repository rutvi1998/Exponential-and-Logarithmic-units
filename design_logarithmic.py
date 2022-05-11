11010011

import math 
import struct
import numpy as np

def floatToBinary32(value):
    	binstr = ''.join(f'{c:0>8b}' for c in struct.pack('!f', value))
    	return binstr[0], binstr[1:9], binstr[9:]

#driver code
if __name__ == "__main__":

#	x_start = 1.18 * pow(10, -38) 
#	x_end = 3.4 * pow(10, 38)

	x_start = 0.0001 
	x_end = 100
	x_size = 0.0001	
		
	q_start = 0
	q_end = 24	
	q_size = 1
	
	min_avg_error = 2147483647
	max_avg_error = -2147483648
	
	min_error_list = []
	max_error_list = []
	
	for q in range(q_start, q_end, q_size):
	
		sum_error = 0
			
		for x in np.arange(x_start * 10, x_end * 10, x_size * 10) / 10: 
			
			sign_bit, exp_str, man_str = floatToBinary32(x)
			
			exp = 0
			for i in range(len(exp_str)):
				exp = exp + pow(2, i) * int(exp_str[7 - i])
			
			man = 1
			for i in range(1, len(man_str) - q + 1):
				man = man + pow(2, -i) * int(man_str[i - 1])

			experimented = ((exp - 127) + math.log2(man)) * math.log(2)
			actual = math.log(x)
			error = abs(experimented - actual)
			sum_error = sum_error + error	
			avg_error = sum_error / ((x_end - x_start) / x_size)	
			
		if(avg_error < min_avg_error):
			min_avg_error = avg_error	
			min_q = q
			min_error_list.append((min_q, min_avg_error))
			
		if(avg_error > max_avg_error):
			max_avg_error = avg_error
			max_q = q
			max_error_list.append((max_q, max_avg_error))
			
	print(min_error_list)
	print(max_error_list)				
