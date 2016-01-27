#@author: Yimy Romero
#Converts hex to binary
.globl _printbin
           .text
   _printbin:
           pushl %ebp
           movl %esp, %ebp
           xorl %eax, %eax
	   xorl %edx, %edx	         #resetting register     
           movb 8(%ebp), %dl       #getting the parameter
           xorl %esi, %esi         #reseting registers
           xorl %edi, %edi
           shrb $4, %dl		   #shifting 4 to the right to the just get hnibble	  
	   call donibble	   #do first high half
	   xorl %edx, %edx	   #reset %edx to get the second half
	   movb 8(%ebp), %dl       #second half
	   andb $0xf, %dl	   #masking to get low nibble
	   movb $8, num		   #resetting 8 '1000' for bit-testing in donibble	
	   incl %esi		   #incrementing %esi to skip the space in outbin
	   call donibble	   #do nibble for the 2nd half
	   movl $outbin, %eax	   #move address of data to %eax to output
           movb $8, num	           #reset 8 '1000' to test multiple times in tutor
           movl %ebp, %esp
           popl %ebp
           ret
         
.data
outbin:
  .ascii "abcd efgh\0"
num:
   .byte 8
.type donibble, @function
donibble:
	movl $4, %ecx		#set counter to loop four times
while:	
	testb num, %dl		#test bit from '1000' to '0001'
	je zero			#if ZF=1 jump
	movb $0x31, outbin(,%esi,1)  #move 1 otherwise to outbin 
	shrb num		#shif right num to test next bit
	incl %esi		#increment esi to place next '0/1' in outbin
	loop while		#repeat loop, four times
ret
zero:
        movb $0x30, outbin(,%esi,1)#move '0' to outbin
	shrb num		#right shift to test next bit
	incl %esi		#increment esi to place next '0/1' in outbin
	loop while		#repeat four times, until ebx = 4
ret
