      .data
A    :.byte 0:150
B    :.byte 0:150
n_A  :.word 0
n_B  :.word 0
I    :.byte 2
str1 : .asciiz "\nSo luong phan tu qua lon(n>150) hoac < 10.Hay nhap lai!"
str2 : .asciiz "\nNhap gia tri cac phan tu mang A:\n"
str4 : .asciiz "\nNhap gia tri cac phan tu mang B:\n"
str3 : .asciiz "\nNhap so luong phan tu: "
      .text
main:
      back:     # th�ng b�o nh?p gi� tr?
            li $v0,4
            la $a0,str3
            syscall
            # nh?p gi� tr?
            li $v0,5
            syscall
            sw $v0,n_A
            lw $t1,n_A
            
            li $v0,5
            syscall
            sw $v0,n_B
            lw $t0,n_B
            # kiem tra
            slti $t2,$t1,10 # n_A<0 ? 1:0
            slti $t3,$t0,0 # n_B<0 ? 1:0
            add $t2,$t2,$t3
            beq $t2,$0,next_check
               li $v0,4
               la $a0,str1
               syscall
               j back
next_check: li $t3,150
            slt $t2,$t3,$t1 # 150<n_B ? 1:0
            slt $t4,$t3,$t0 # 150< n_B ? 1:0
            add $t2,$t2,$t4 
            beq $t2,$0,next_part
                li $v0,4
                la $a0,str1
                syscall
                j back
next_part: 
            # thong bao nhap cho A
            li $v0,4
            la $a0,str2
            syscall
            li $t2,0 		# Indexx
    loop:   beq $t2,$t1,next
            li $v0,5
            syscall
            sb $v0,A($t2)
            addi $t2,$t2,1
            j loop
    next: 
           # Yeu cau nhap cho B
            li $v0,4
            la $a0,str4
            syscall
            li $t2,0		 # Indexz
    loop1:   
            beq $t2,$t0,next_part1
            li $v0,5
            syscall
            sb $v0,B($t2)
            addi $t2,$t2,1
            j loop1
next_part1:        
            lb $s0,I # indexx
            li $t3,10 # break
            la $s1,A  # s1 <- & A
            la $s2,B  # s2 <- & B
     loop2: slt $t4,$s0,$t3 
            beq $t4,$0,end
              addi $t4,$s0,-2 		# t4 = I-2
              add $t4,$t4,$s1 		# t4 = &A[I-2]
              lb $t4,0($t4)   		# t4 = A[I-2]
              add $t4,$t4,$s2 		# t4 = &B[A[I-2]]
              lb $t4,0($t4)   		# t4 = B[A[I-2]]
              add $s3,$s0,$s1 		# s3 = &A[I]
              sb $t4,0($s3)   		# A[I] = B[A[I-2]]
              addi $s0,$s0,1
              j loop2
      end:
