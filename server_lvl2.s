#write a program that create a socket
.intel_syntax noprefix
.globl _start

.section .text

_start:
	mov rdi, 2 #define AF_INET     2
    mov rsi, 1  #define SOCK_STREAM 1
    mov rdx, 0  #define IPPROTO_IP  0
	mov rax, 41 #SYS_socket
	syscall
	jmp exit

exit:
    mov rdi, 0
    mov rax, 60     # SYS_exit
    syscall

.section .data
