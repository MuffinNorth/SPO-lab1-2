	.file	"main.c"
	.text
	.globl	fractal
	.type	fractal, @function
fractal:   ;метка функции fractal
.LFB23:
	.cfi_startproc
	endbr64
	movl	$1, %eax ;перемещения единицы в регистр return.на $1 - число 1 / %eax - регистр возвращаемого значения
	cmpl	$1, %edi ;сравнения n с единицой 
	jle	.L5 ;если предыдущая строчка правда, то прыжок на метке L5 
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx ;сохранение n в регистре ebx
	leal	-1(%rdi), %edi ;вычитание единицы из регистра edi(аргумент функции - n)
	call	fractal ;вызов функции fractal с аргументом из регистра edi
	imull	%ebx, %eax ;умножение сохраненного n(в ebx) с регистром возвращаемого значения, то есть три предыдущие инструкции сделали return n*fractal(n-1)
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret ;выход из функции возвращает значение в eax
.L5:
	.cfi_restore 3
	ret ;выход из функции возвращает значение в eax
	.cfi_endproc
.LFE23:
	.size	fractal, .-fractal
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Fractal %d = %d \n" ;текст который будет напечатан printfом
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$5, %edi ;Перемещение числа 5 в регистр аргумента
	call	fractal ;Вызов функции fractal с аргументом 5
	movl	%eax, %ecx ;Перемещение результата функции в ecx
	movl	$5, %edx   ;Перемещение 5 в edx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT ;Печать текста
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
