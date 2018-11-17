%include "asm_io.inc"

segment .data               ; espaço para variáveis inicializadas
    pilares dd 0            ; quantidade de pilares 
    pontes dd 0             ; quantidade de pontes
    pilarDe dd 0            ; numero do pilar inicial 
    pilarPara dd 0          ; numero do pilar destino
    buracos dd 0            ; quantidade de buracos entre o pilar inicial e o pilar destino
    resultado dd 0          ; menor quantidade de buracos possiveis para atravessar de 0 a N+1 
    no dd -1
    i dd 0
    y dd 0
    msg1 dd "teste ", 0
    soma dd 0

segment .bss                ; espaço para variáveis reservadas
    ; O valor de N é considerado no máximo e com uma margem de erro de 10 pra mais
    A resd 3600             ; A = matriz NxN
    visitado resd 60        ; visitado = vetor[N] 
    dis resd 60             ; dis = vetor[N] 
    espaco resb 1           ; espaço entre os numeros
    
segment .text               ; código do programa
    global asm_main
    



asm_main:                   ; função main
    call read_int           ; eax = numero de pilares no desfiladeiro
    add eax, 2              ; eax += 2 
    mov [pilares], eax      ; [pilares] = eax
    
    call read_int           ; eax = numero de pontes no desfiladeiro
    mov [pontes], eax       ; [pontes] = eax   
    
    call read_char
    
    mov edi, A
    mov ecx, 3600 
definematrix:
    mov eax, 0x3f
    stosd
    loop definematrix
    
    mov ecx, [pontes]       ; ecx = [pontes] para realizar as M leituras de S, T e B

readingfor:

    call read_int           ; lê o valor S em eax
    mov [pilarDe], eax      ; [pilarDe] = eax
    
    call read_char          ; para o espaço entre os numeros
    
    call read_int           ; lê o valor de T em eax
    mov [pilarPara], eax    ; [pilarPara] = eax
    
    call read_char          ; para o espaço entre os numeros
    
    call read_int           ; lê o valor de B em eax
    mov [buracos], eax      ; [buracos] = eax
    
    call read_char          ; para o enter pros próximos numeros
    
    ;Calculo da posição da matriz de maneira rowwise
    mov eax, 50
    mov ebx, [pilarDe]
    imul ebx
    add eax, [pilarPara]
    mov edx, [buracos]
    mov [A+eax], edx        ; A[S][T] = B
    
    mov eax, 50
    mov ebx, [pilarPara]
    imul ebx
    add eax, [pilarDe]
    mov edx, [buracos]
    mov [A+eax], edx        ; A[T][S] = B
    loop readingfor 
    

resolve:                   ; função dijkstra

    mov edi, dis
    mov ecx, 60
definedistance:
    mov eax, 0x3f
    stosd
    loop definedistance     ; inicializa todas as posições do vetor dis como 0x3f
    
    mov edi, visitado
    mov ecx, 60
definevisitado:
    mov eax, 0
    stosd
    loop definevisitado     ; inicializa todas as posições do vetor visitado como 0

    mov edi, dis
    mov eax, 0
    stosd                   ; dis[0] = 0

    
    mov ecx, [pilares]
    mov [y], ecx

externfor:
    mov edx, -1             ; edx = no 
    
    mov [y], ecx            
    mov ecx, [pilares]
    mov esi, visitado
    
innerfor:
    lodsd                   ; eax = visitado[i]
    cmp eax, 1              ; eax == 1
    je end                  ; se sim, end
    cmp edx, -1             ; edx == -1
    je condicao             ; se sim, condicao
    mov eax, [pilares]
    sub eax, ecx
    mov [i], eax
    mov ebx, [dis + eax]    ; ebx = dis[i]
    mov eax, [dis + edx]    ; eax = dis[edx]
    cmp ebx, eax
    jl condicao
    jmp end
condicao:
    mov edx, [i]            ; edx = eax
end:
    loop innerfor
    
    cmp edx, -1
    je break
    
    mov [visitado+edx], dword 1
    
    mov ecx, [pilares]
innerfor2:
    mov eax, 0
    imul eax, edx, 50
    mov ebx, [pilares]
    sub ebx, ecx
    add eax, ebx            ; eax = [no][i]           
    mov ebx, [dis+edx]
    add ebx, [A+eax]        ; ebx = dis[no] + A[no][i]
    mov [soma], ebx
    mov ebx, [pilares]
    sub ebx, ecx
    mov eax, [soma]
    cmp eax, [dis+ebx]      ; soma >= dis[i]
    jge endinnerfor2
    mov [dis+ebx], eax
endinnerfor2:
    loop innerfor2    
endexternfor:
    mov ecx, [y]
    dec ecx
    cmp ecx, 0
    jg externfor
break:
    mov ebx, [pilares]
    dec ebx
    mov eax, [dis+ebx] 
    call print_int
    call print_nl
    
    leave
    ret

    
