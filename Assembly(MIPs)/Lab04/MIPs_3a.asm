	.data

char1:	.word
out1:	.asciiz "\nKy tu truoc: "
out2:	.asciiz "\nKy tu sau: "
stop:	.asciiz "\ninvalid type"

	.text

start:
	li $v0,12
	syscall
	add $t1,$v0,-1
	add $t2,$v0,1
	
	
	addi $s7,$0,2		# s7 = 2; result check code.
	add  $s0,$0,$v0		# s0 = char;
	
#Kiem tra: 1->9
	addi $s1,$0,48		# s1 = 48;
	slt  $t5,$s1,$s0	# 48 < s0; => t5 =0|1;
	add  $t0,$t0,$t5	# Sum(t0);
	slti $t6,$s0,57		# s0 < 57; => t6=0|1;
	add  $t0,$t0,$t6	# Sum(t0);
	beq  $t0,$s7,right	# t0 == 2; => j right;
	
#Khoi tao lai 2 bien ktra ve 0,0
	addi $t0,$0,0		# Sum =0;
	addi $t5,$0,0
	addi $t6,$0,0
	
#Kiem tra: A->Z
	addi $s1,$0,65		# s1 = 65;
	slt  $t5,$s1,$s0	# 65 < s0; => t5 =0|1:
	add  $t0,$t0,$t5	# Sum(t0);
	slti $t6,$s0,90		# s0 < 90; => t6 =0|1;
	add  $t0,$t0,$t6	# Sum(t0);
	beq  $t0,$s7,right	# t0 == 2; => j right;
	
#Khoi tao lai 2 bien ktra ve 0,0
	addi $t0,$0,0		# Sum =0;
	addi $t5,$0,0
	addi $t6,$0,0
	
#Kiem tra: a->z
	addi $s1,$0,97		# s1= 97;
	slt  $t5,$s1,$s0	# s1(97) < s0; => t5 =0|1;
	add  $t0,$t0,$t5	# Sum(t0);
	slti $t6,$s0,122	# s0 < 122; => t6 =0|1;
	add  $t0,$t0,$t6	# Sum(t0);
	beq  $t0,$s7,right	# t0 == 2; => j right;


	j wrong

	
right:
	li $v0,4
	la $a0,out1
	syscall
	
	move $a0,$t1
	li $v0,11
	syscall
	
	li $v0,4
	la $a0,out2
	syscall
	
	move $a0,$t2
	li $v0,11
	syscall
	
	j EXIT
	
wrong:
	li $v0,4
	la $a0,stop
	syscall
	
EXIT:
	

#Y tuong: So nhap vao phai la ("int","char","CHAR")	
#	- Kiem tra lan` luot. 3 case: 48<char<57;  65<char<90;   97<char<122;
#	Voi moi case: a<char<b => ta chia lam 2 lan check: (a < char) + (char < b)
#							     t5=0|1	  t6=0|1
#			Neu t5 + t6 ==2 tuc la ca 2 case deu dung';
#			Neu t5 + t6 !=2, reset cac bien kiem tra va` bien Sum ve 0
#			=> Thuc hien case tiep theo tuong tu cho toi khi dung' thi JUMP to RIGHT.

	
	
