import math 
import struct
import numpy as np

#driver code
if __name__ == "__main__":

	x_start = -8
	x_end = 0	
	x_size = 0.001
	
	x = -2.75
	
	step_start = 0.1
	step_end = 1.0	
	step_size = 0.01

	min_avg_error = 2147483647
	max_avg_error = -2147483648
	
	min_error_list = []
	max_error_list = []
	
	#range for floats with np.arange()
	for step in np.arange(step_start * 10, step_end * 10, step_size * 10) / 10:
		
		sum_error = 0
		
		x_l = int(x / step) * step;
		y_l = math.exp(x_l)
		a = (math.exp(x_l + step) - y_l) / step
		b = y_l - a * x_l #represents y_l - a * x_l
		experimented = a * x + b
		actual = math.exp(x)
		error = abs(experimented - actual)
		sum_error = sum_error + error	
		avg_error = sum_error / ((x_end - x_start) / x_size)	
		
		if(avg_error < min_avg_error):
			min_avg_error = avg_error	
			min_step = step
			min_error_list.append((min_step, min_avg_error))
			
		if(avg_error > max_avg_error):
			max_avg_error = avg_error
			max_step = step
			max_error_list.append((max_step, max_avg_error))
			
	print(min_error_list)
	print(max_error_list)				
