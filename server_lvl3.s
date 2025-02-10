#write a program that create a socket
.intel_syntax noprefix
.globl _start

.section .text

_start:

socket:
	mov rdi, 2 #define AF_INET     2
    mov rsi, 1  #define SOCK_STREAM 1
    mov rdx, 0  #define IPPROTO_IP  0
	mov rax, 41 #SYS_socket
	syscall

bind:
    mov rdi, 3   #socket to bind
    lea rsi, stuct
    mov rdx, 16   #adresslen
    mov rax, 49  #SYS_bind
    syscall

exit:
    mov rdi, 0
    mov rax, 60     # SYS_exit
    syscall

.section .data

stuct: 
    sa_family: .short 2
    sin_port: .short 0x5000 # port 80 -> 0x5000 -> 0x0050
    sin_addr: .long 0       # adress 0.0.0.0