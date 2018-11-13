%include "asm_io.inc"

segment .data               ; espaço para variáveis inicializadas
    pilares db 0            ; quantidade de pilares 
    pontes db 0             ; quantidade de pontes
    pilarDe db 0            ; numero do pilar inicial 
    pilarPara db 0          ; numero do pilar destino
    buracos db 0            ; quantidade de buracos entre o pilar inicial e o pilar destino
    resultado db 0          ; menor quantidade de buracos possiveis para atravessar de 0 a N+1 

segment .bss                ; espaço para variáveis reservadas
    A resd 1010             ; A = matriz[N][N] 
    visitado resd 50        ; visitado = vetor[N] 
    dis resd 50             ; dis = vetor[N]
    espaco resb 1           ; espaço entre os numeros
    
segment .text               ; código do programa
    global asm_main
    
dijkstra:                   ; função dijkstra
    ; TODO
    mov eax, [resultado]    ; eax = resultado
    ret                     ; retorna o resultado em eax


asm_main:                   ; função main

    call read_int           ; eax = numero de pilares no desfiladeiro
    mov [pilares], eax      ; [pilares] = eax

    call read_int           ; eax = numero de pontes no desfiladeiro
    mov [pontes], eax       ; [pontes] = eax   

    mov ecx, [pontes]       ; ecx = [pontes] para realizar as M leituras de S, T e B
readingfor:

    call read_int
    mov [pilarDe], eax

    call read_int
    mov [pilarPara], eax
    
    call read_int
    mov [buracos], eax

    ; Inserir na matriz A[pilarDe][pilarPara] = A[pilarPara][pilarDe] = buracos
    ; code here
    
    loop readingfor    

    push A                
    call dijkstra         ; a função deve retornar em eax o resultado calculado
    
    call print_int
    call print_nl
    
    leave
    ret

    
