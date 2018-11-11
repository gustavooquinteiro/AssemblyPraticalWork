%include "asm_io.inc"

segment .data   ; espaço para variáveis inicializadas
    pilares db 0
    pontes db 0
    pilarDe db 0
    pilarPara db 0
    buracos db 0
    resultado db 0

segment .bss            ; espaço para variáveis reservadas
    N resb 2            ; N = numero de pilares no desfiladeiro (1 ≤ N ≤ 50)
    M resb 3            ; M = numero de pontes (2 ≤ M ≤ 100)
    S resb 2            ; S = pilar inicial (0 ≤ S ≤ N + 1)
    T resb 2            ; T = pilar final (0 ≤ T ≤ N + 1)
    B resb 2            ; B = quantidade de buracos entre S e T (0 ≤ B ≤ 50);
    A resb 1010         ; A = matriz[N][N] 
    visitado resb 50    ; visitado = vetor[N] 
    dis resb 50         ; dis = vetor[N]
    espaco resb 1       ; espaço entre os numeros
    R resb 3            ; R = resultado convertido para char 
    
segment .text   ; código do programa
    ;global _start
    global asm_main
    
dijkstra:
    ; dijkstra nasm code here
    ret

    
convert3:
    push ebp
    mov ebp, esp
    mov edi, [ebp+8]
    mov esi, [ebp+8]
    cld
    mov ecx, 3
    
    
converting3for:
    lodsb
    sub al, 48
    stosb
    
    loop converting3for
    
    mov eax, 0
    mov edx, 0
	cld
	mov esi, [ebp+8]
	
	mov eax, 0    
	lodsb
	mov cl, 100
	mul cl
	add edx, eax

    mov eax, 0    
	lodsb
	mov cl, 10
	mul cl
	add edx, eax
	
	mov eax, 0
	lodsb
	add edx, eax
	mov eax, edx
	
    pop ebp
    
    ret
    
    
convert2:
    push ebp
    mov ebp, esp
    mov edi, [ebp+8]
    mov esi, [ebp+8]
    cld
    mov ecx, 2
    
    
converting2for:
    lodsb
    sub al, 48
    stosb
    
    loop converting2for
    
    mov eax, 0
    mov edx, 0
	cld
	mov esi, [ebp+8]

    mov eax, 0    
	lodsb
	mov cl, 10
	mul cl
	add edx, eax
	
	mov eax, 0
	lodsb
	add eax, edx

    pop ebp
    
    ret
    

convert:
    push ebp
    mov ebp, esp
    mov edi, [ebp+8]
    mov esi, [ebp+8]
    cld
    mov ecx, 1
    
    
convertingfor:
    lodsb
    sub al, 48
    stosb
    
    loop convertingfor
    
    mov eax, 0
    mov edx, 0
	cld
	mov esi, [ebp+8]

	mov eax, 0
	lodsb
	add eax, edx

    pop ebp
    
    ret    
    
;_start:
asm_main:
    ; Leitura de N
    mov eax, 3
    mov ebx, 0
    mov ecx, N
    mov edx, 2
    int 0x80
    
    push N
    call convert
    mov [pilares], eax
    
    call print_int
	call print_nl
    
    ; Leitura de um espaço entre os numeros
    mov eax, 3
    mov ebx, 0
    mov ecx, espaco
    mov edx, 1
    int 0x80
    
    ; Leitura de M
    mov eax, 3
    mov ebx, 0
    mov ecx, M
    mov edx, 3
    int 0x80
    
    push M
    call convert
    mov [pontes], eax
    
    ; M leituras de S, T e B
    mov ecx, [pontes]
    dec ecx
    mov [pontes], ecx
readingfor:

    mov eax, 3
    mov ebx, 0
    mov ecx, S
    mov edx, 2
    int 0x80
    
    push S
    call convert
    mov [pilarDe], eax
    
    ; Leitura de um espaço entre os numeros
    mov eax, 3
    mov ebx, 0
    mov ecx, espaco
    mov edx, 1
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, T
    mov edx, 2
    int 0x80
    
    push T
    call convert
    mov [pilarPara], eax
    
    ; Leitura de um espaço entre os numeros
    mov eax, 3
    mov ebx, 0
    mov ecx, espaco
    mov edx, 1
    int 0x80
    
    mov eax, 3
    mov ebx, 0
    mov ecx, B
    mov edx, 2
    int 0x80
    
    push B
    call convert
    mov [buracos], eax
    
    ; Inserir na matriz A[pilarDe][pilarPara] = A[pilarPara][pilarDe] = buracos
    ; code here
    
    mov ecx, [pontes]
    mov edx, 0
    cmp ecx, edx
    je solve
    dec ecx
    mov [pontes], ecx
    jmp readingfor
    
solve:
    push A
    call dijkstra
    mov [resultado], eax
    
    ; Escrita na saída padrão do resultado  
    ; code here
    
    
    mov eax, 1
    mov ebx, 0
    int 80h 


    
