	.data
input:		.asciiz "\nNhap: "
output:		.asciiz "\nSo lon hon: "
addition:	.asciiz "\nTong: "
subtraction:	.asciiz "\nHieu: "
division:	.asciiz "\nThuong: "
multiplication:	.asciiz "\nTich: "

number1:	.word
number2:	.word

	.text
	
start:
	addi	$v0,$0,4
	la	$a0,input
	syscall
	
	addi	$v0,$0,5
	syscall
	move	$t1,$v0		# t1 = number1;
	
	addi	$v0,$0,5
	syscall
	move	$t2,$v0		# t2 = number2;
	
# Bigger Number:

	slt	$s7,$t1,$t2	
	beq	$s7,1,twolessone	# num1<num2 => print ( num2 );
	j 	onelesstwo			# else	=> print (num1 );
	
continue1:
# Addition: ( s1 )
	add	$s1,$t1,$t2
	
	# print addition
	la	$v0,4
	la	$a0,addition
	syscall
	
	la	$v0,1
	move	$a0,$s1
	syscall
	
# Subtraction: ( s2 )
	sub	$s2,$t1,$t2
	
	# print
	la	$v0,4
	la	$a0,subtraction
	syscall
	
	la	$v0,1
	move	$a0,$s2
	syscall
	
# Multiplication: ( s3 )
	mult	$t1,$t2
	mflo	$s3		# s3 = lo
	
	# print
	la	$v0,4
	la	$a0,multiplication
	syscall
	
	la	$v0,1
	move	$a0,$s3
	syscall
	
# Division: ( s4/s5 )
	div	$t1,$t2
	mflo	$s4		# s4 = lo;
	mfhi	$s5		# s5 = hi;
	
	# print
	la	$v0,4
	la	$a0,division
	syscall
	
	la	$v0,1
	move	$a0,$s4
	syscall
	
#	Finish
	
	j	EXIT

twolessone:
	la	$v0,4
	la	$a0,output
	syscall

	la	$v0,1
	move	$a0,$t2
	syscall
	
	j	continue1
	
onelesstwo:
	la	$v0,4
	la	$a0,output
	syscall

	la	$v0,1
	move	$a0,$t1
	syscall
	
	j	continue1
	
	
EXIT:
	
	
	
	
	
	
	
