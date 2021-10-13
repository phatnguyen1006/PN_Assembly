	.data
Arr:	.byte 0:20
strMax:	.asciiz "\nMax: "
strMin:	.asciiz "\nMin: "
strSum:	.asciiz "\nTotal: "
str1:	.asciiz "Arr["
str2:	.asciiz "]: "
sp:	.asciiz " "
	.text
start:
	
	# Nhap n:
	li	$v0,5
	syscall
	move	$t0,$v0		# t0 =size;
	
	# Thao tac:
	## Nhap mang:
	
	li	$t1,0		# index =0;
	la	$s0,Arr		# s0 =Arr;
for1:
	beq	$t0,$t1,continue# ( t0 == index )? -> j end.
	
	li	$v0,5		# read integer
	syscall
	
	sb	$v0,0($s0)	# s0 <- v0
	addi	$t1,$t1,1	# index ++;
	
	addi	$s0,$s0,1	# & Next Word
	
	j	for1

#-- main--	
continue:
	jal	print		# print Arr
	jal	a		# Call function
	jal	printMin	# Callback();
	jal	b		# Call function b
	jal	printTotal	# Callback();
	jal	c		# Call function	c

	j	end
#-- 	--
	
	# In Mang:
print:
	li	$t1,0		# reset indexl;
	la	$s0,Arr		# s0 =Arr;
	for2:
	beq	$t0,$t1,break	# (..)? => j end;
	
	lb	$a0,0($s0)	# Load data;
	li	$v0,1		# Print integer;
	syscall
	
	li	$v0,4
	la	$a0,sp
	syscall
	
	addi	$t1,$t1,1	# index ++;
	addi	$s0,$s0,1	# Load & Next Word;
	
	j	for2
break:	
	jr	$ra
	


a:
# Y tuong:
#	define max=Arr[0];
#	Arr++;
#	(Arr[i] > Max)? Max = Arr[i] : continue;
	
	la	$a1,Arr		# Max <- & Arr[0];
	li	$t1,0		# reset index;
	
	addi	$t0,$t0,-1	# Set stop point
	
	li	$a2,0		# define a2;
	lb	$s0,0($a1)	# Max: s0 <- a1		Sau khi da load byte len thi chay toi bien tiep theo de so sanh
	lb	$s7,0($a1)	# Min: s1 <- a1		Load len tuong tu Max
	for:
	beq	$t1,$t0,break	# ( t1 == t0 [size])? => finish loop
	
	addi	$t1,$t1,1	# index ++;
	add	$a2,$a1,$t1	# & Next Word;
	
	
	lb	$a2,0($a2)	# load byte &a2 -> a2;
	
	slt	$s1,$s0,$a2	# ( s0 [max] < a2 )?
	slt	$s2,$a2,$s7	# ( a2 < s7 [Min])?
	
	
	beq	$s1,1,assignMax	# (s1 == 1)? j to assignMax
	beq	$s2,1,assignMin	# (s2 == 1)? j to assingMin
	
	j	for
	
assignMax:
	add	$s0,$0,$a2	# Max s0 = a2;
	 j	for
	 
assignMin:
	add	$s7,$0,$a2	
	j	for
	 
	
printMin:
	li	$v0,4
	la	$a0,strMin
	syscall
	
	li	$v0,1
	move	$a0,$s7
	syscall
	
	li	$v0,4
	la	$a0,strMax
	syscall
	
	li	$v0,1
	move	$a0,$s0
	syscall
	
	jr	$ra
	
b:
	
	li	$t1,0		# reset index;
	li	$a2,0		# define a2;
	lb	$s0,0($a1)	# s0 <- a1		Sau khi da load byte len thi chay toi bien tiep theo de so sanh
	add	$a3,$0,$s0
for3:
	beq	$t1,$t0,break	# (t1 == t0 [size])? => finish loop
	
	addi	$t1,$t1,1	# index ++;
	add	$a2,$a1,$t1	# & Next Word;
	
	lb	$a2,0($a2)	# load byte &a2 -> a2;
	
	add	$a3,$a3,$a2	# Sum: a3 += a2;
	
	j	for3
	
printTotal:
	li	$v0,4
	la	$a0,strSum
	syscall
	
	li	$v0,1
	move	$a0,$a3
	syscall

	jr	$ra
	
c:
	li	$v0,5
	syscall
	move	$t0,$v0

	li	$t1,0		# reset indexl;
	la	$s0,Arr		# s0 =Arr;
	for4:
	beq	$t0,$t1,output	# (..)? => j end;
	
	
	addi	$t1,$t1,1	# index ++;
	addi	$s0,$s0,1	# Load & Next Word;
	
	j	for4
	
output:
	lb	$a0,0($s0)	# Load data;
	
	li	$v0,1		# Print integer;
	syscall
	
	li	$v0,4
	la	$a0,sp
	syscall
	
	jr	$ra

end:


# Notes:
#	a, $s0: Max
#	   $s7: Min
