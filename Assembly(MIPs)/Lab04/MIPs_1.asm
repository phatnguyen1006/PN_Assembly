	.data
	.text
	
start:
	beq $s0,$s1,sum
	sub $s2,$t0,$t1
	j EXIT
	sum:
		add $s2,$t0,$t1
	EXIT: