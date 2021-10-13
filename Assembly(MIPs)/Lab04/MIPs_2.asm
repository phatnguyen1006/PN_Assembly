	.data
	.text

start:
	addi $s2,$0,0	#Sum =0;
	addi $s1,$0,6	#N=6;
	addi $s0,$0,1	#int i=1;
	
	for:
		beq $s0,$s1,exit
			add $s2,$s2,$s0		#Sum= Sum +i;
			addi $s0,$s0,1		# i += 1;
			j for
		exit:
	
