      .data
A    :.byte 0:300
size :.word 0
I    :.byte 0
J    :.byte 0
str1 : .asciiz "\nSo luong phan tu qua lon(n>300) hoac la so am.Hay nhap lai!"
str2 : .asciiz "\nNhap gia tri cac phan tu:\n"
str3 : .asciiz "\nNhap so luong phan tu: "
      .text
main:
      back:     # Yeu cau nhap
            li $v0,4
            la $a0,str3
            syscall
            # Nhap
            li $v0,5
            syscall
            sw $v0,size
            lw $t1,size
            # Check
            slt $t2,$t1,$0 	# size<0 ? 1:0
            beq $t2,$0,next_check
               li $v0,4
               la $a0,str1
               syscall
               j back
next_check: li $t3,300
            slt $t2,$t3,$t1 	# 300<size ? 1:0
            beq $t2,$0,next_part
                li $v0,4
                la $a0,str1
                syscall
                j back
next_part: 
            # Yeu cau nhap
            li $v0,4
            la $a0,str2
            syscall
            li $t2,0 		# Index
    loop:   beq $t2,$t1,next
            li $v0,5
            syscall
            sb $v0,A($t2)
            addi $t2,$t2,1
            j loop
    next: 
            la $s3,A
            lb $s0,I
            lb $s1,J
            slt $t1,$s0,$s1 	# i<j ?1:0
            beq $t1,$0,true
              sb $s1,A($s2)
              j end
    true:   sb $s1,A($s1)
     end:
            



