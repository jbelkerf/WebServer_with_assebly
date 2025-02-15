#Multi-processed program that dynamically responds to multiple HTTP GET requests
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

listen:
	mov rdi, 3
	mov rsi, 0	
	mov rax, 50
	syscall

accept:
	mov rdi, 3
	mov rsi, 0
	mov rdx, 0
	mov rax, 43
	syscall

fork:
	mov rax, 57
	syscall
cmp rax, 0                     #if (pid == 0)
je child                       #do child
colse:
	mov rdi, 4
	mov rax, 3
	syscall

accept2:
	mov rdi, 3
	mov rsi, 0
	mov rdx, 0
	mov rax, 43
	syscall

exit:
    mov rdi, 0
    mov rax, 60     # SYS_exit
    syscall

child:

colse3:
	mov rdi, 3
	mov rax, 3
	syscall

read:
	mov rdi, 4
	mov rsi, rsp
	mov rdx, 1000
	mov rax, 0
	syscall

mov BYTE PTR [rsp + 20], 0

open_target_file:
    mov r9, rsp
    add r9, 4
    mov rdi, r9
    mov rsi, 0
    mov rax, 2
    syscall

mov r9, rax          #save the target filediscreptor in r9

read2:
	mov rdi, r9
	mov rsi, rsp
	mov rdx, 1000
	mov rax, 0
	syscall

mov r10, rax         #save the file size
colse2:
	mov rdi, r9
	mov rax, 3
	syscall

write1:
	mov rdi, 4
	lea rsi, [rip + response]
	mov rdx, 19
	mov rax, 1
	syscall

write2:
    mov rdi, 4
    mov rsi, rsp
    mov rdx, r10
    mov rax, 1
    syscall
jmp exit

.section .data

stuct: 
    sa_family: .short 2
    sin_port: .short 0x5000 # port 80 -> 0x5000 -> 0x0050
    sin_addr: .long 0       # adress 0.0.0.0

response:
.asciz "HTTP/1.0 200 OK\r\n\r\n"
