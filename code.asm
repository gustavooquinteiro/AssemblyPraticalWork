%include "asm_io.inc"

segment .data               ; espaço para variáveis inicializadas
    pilares dd 0            ; quantidade de pilares 
    pontes dd 0             ; quantidade de pontes
    pilarDe dd 0            ; numero do pilar inicial 
    pilarPara dd 0          ; numero do pilar destino
    buracos dd 0            ; quantidade de buracos entre o pilar inicial e o pilar destino
    resultado dd 0          ; menor quantidade de buracos possiveis para atravessar de 0 a N+1 
    no dd -1

segment .bss                ; espaço para variáveis reservadas
    A resd 2500             ; A = matriz[N][N] 
    visitado resd 1010      ; visitado = vetor[N] 
    dis resd 1010           ; dis = vetor[N]
    espaco resb 1           ; espaço entre os numeros
    
segment .text               ; código do programa
    global asm_main
    
dijkstra:                   ; função dijkstra
    mov edi, dis
    mov ecx, 1010
definedistance:
    mov eax, 0x3f
    stosd
    loop definedistance
    
    mov edi, visitado
    mov ecx, 1010
definevisitado:
    mov eax, 0x3f
    stosd
    loop definevisitado        
    ;mov eax, [resultado]    ; eax = resultado
    ret                     ; retorna o resultado em eax


asm_main:                   ; função main
    mov eax, 0
    call read_int           ; eax = numero de pilares no desfiladeiro
    mov [pilares], eax      ; [pilares] = eax
    
    call read_int           ; eax = numero de pontes no desfiladeiro
    mov [pontes], eax       ; [pontes] = eax   
    
    call read_char
    
    mov edi, A
    mov ecx, 2500
definematrix:
    mov ax, 0x3f
    stosd
    loop definematrix
    
    mov ecx, [pontes]       ; ecx = [pontes] para realizar as M leituras de S, T e B
    
readingfor:

    call read_int
    mov [pilarDe], eax  
    
    call read_char          ; para o espaço entre os numeros
    
    call read_int
    mov [pilarPara], eax
    
    call read_char          ; para o espaço entre os numeros
    
    call read_int
    mov [buracos], eax
    
    call read_char          ; para o enter pros próximos numeros
    
    ;Rowwise
    mov eax, 50
    mov ebx, [pilarDe]
    imul ebx
    add eax, [pilarPara]
    mov edx, [buracos]
    mov [A+eax], edx
    
    mov eax, 50
    mov ebx, [pilarPara]
    imul ebx
    add eax, [pilarDe]
    mov edx, [buracos]
    mov [A+eax], edx
    
    loop readingfor   
        
    call dijkstra         ; a função deve retornar em eax o resultado calculado 
    call print_int
    call print_nl
    
    leave
    ret

    
