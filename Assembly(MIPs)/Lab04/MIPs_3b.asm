	.data
number:	.word

stop:	.asciiz "invalid Entry"

name0:	.asciiz "Zero"
name1:	.asciiz "One"
name2:	.asciiz "Two"
name3:	.asciiz "Three"
name4:	.asciiz "Four"
name5:	.asciiz "Five"
name6:	.asciiz "Six"
name7:	.asciiz "Seven"
name8:	.asciiz "Eight"
name9:	.asciiz "Nine"

	.text
	
start:
	li	$v0,5
	syscall
	move	$s0,$v0
	
#Check: ( 100->999 )
	li	$s7,2		# checkcode s7 =2;
	li	$t8,99		# t8 = 99;
	li	$t9,1000	# t9 = 1001;
	slt	$t5,$t8,$s0	# t8 (99) < s0; => t5 =0|1;
	add	$t0,$t0,$t5	# Sum(t0);
	slt	$t6,$s0,$t9	# s0 < t9 (1001); => t6=0|1;
	add	$t0,$t0,$t6	# Sum(t0);
	beq	$t0,$s7,continue# t0 == s7; => j continue;
	j	END		# else => j END
	
continue:
# Num= abc;
	li	$t1,10		# t1 =10;
# Take c;
	div	$s0,$t1		# abc : 10 => Lo: ab;  Hi: c;
	mfhi	$s3		# s3 =c;
	mflo	$s0		# s0 =ab;
# Take b,a;
	div	$s0,$t1		# ab : 10 => Lo: a;  Hi: b;
	mfhi	$s2		# s2 =b;
	mflo	$s1		# s1 =a;
	
# Start to read:

#a
	li	$v0,4
	move	$t1,$s1		# t1 =s1; truyen bien s1 vao` ham`.
	li	$t2,1		# Danh so thu tu: a =1; => t2
	j	SWITCH
a:
	syscall
	
	li	$v0,11
	la	$a0,32
	syscall

#b
	li	$v0,4
	move	$t1,$s2		# t1 =s2; truyen bien s2 vao` ham`.
	li	$t2,2		# b =2; => t2
	j	SWITCH
b:
	syscall
	
	li	$v0,11
	la	$a0,32
	syscall
	
#c
	li	$v0,4
	move	$t1,$s3		# t1 =s3; truyen bien s3 vao` ham`.
	li	$t2,3		# c =3; => t2
	j	SWITCH
c:
	syscall
	

	j	EXIT
		
###################	


SWITCH:
zero:
	bne	$t1,0,one
	la	$a0,name0
	j	return
one:
	bne	$t1,1,two
	la	$a0,name1
	j	return
two:
	bne	$t1,2,three
	la	$a0,name2
	j	return
three:
	bne	$t1,3,four
	la	$a0,name3
	j	return
four:
	bne	$t1,4,five
	la	$a0,name4
	j	return
five:
	bne	$t1,5,six
	la	$a0,name5
	j	return
six:
	bne	$t1,6,seven
	la	$a0,name6
	j	return
seven:
	bne	$t1,7,eight
	la	$a0,name7
	j	return
eight:
	bne	$t1,8,nine
	la	$a0,name8
	j	return
nine:
	la	$a0,name9
return:
	beq	$t2,1,a
	beq	$t2,2,b
	beq	$t2,3,c
	

	
END:
	li	$v0,4
	la	$a0,stop
	syscall
	
EXIT:
	
	
# Y tuong:	Viet 1 ham de truyen vao bien s1,s2,s3
#			Check xem so do la bao nhieu sau do return ve a0 mang gia tri la` ten cua so do.
	
