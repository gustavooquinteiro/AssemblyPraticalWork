#include <stdio.h>

int vetor[300];
int n, m;
int calc [300][300];


int min(int a, int b){
    if(a < b) 
        return a;
    return b;
}


// Tá uma merda não funciona nada
int resolve(int indice, int final, int quantidadePontes){

    int caminho = 0;
    int estadoInicial = vetor[3*indice];
    int estadoFinal = vetor[3*indice + 1];
    int buracos = vetor[3*indice +2];
        
    printf("EI==%d  EF==%d BURACOS==%d FINAL==%d\n", estadoInicial, estadoFinal, buracos, final);
    
    if (estadoFinal == final+1) {
        /**
         * Fulaninho chegou do outro lado do desfiladeiro
         * retorna a quantidade de buracos
        **/
        printf("CHEGOU!\n");
        return buracos; 
    }else{
        
        int index = indice+1;
        if (vetor[3*index] == estadoFinal){
            /** 
             * caminho sequencial: o proximo estadoInicial é igual ao estadoFinal atual, exemplo:
             * 0 1 1
             * 1 2 1
             * 2 3 1 
            **/
            printf("CAMINHO SEQUENCIAL EI==%d EFL==%d  \n", estadoInicial, estadoFinal);
            caminho += resolve(index, final, quantidadePontes);
        }else{ 
            /** tem outro caminho partindo desse indice, exemplo:
             * 0 1 1
             * 0 2 1
             * 0 3 1
             **/
            
            for(int i = index; i < quantidadePontes; i++){
                if(vetor[3*i] != estadoInicial) 
                    break;
                printf("OUTRO CAMINHO EI==%d EF==%d  \n", estadoInicial, estadoFinal);    
                caminho += resolve(i, final, quantidadePontes);     
                
            }
            
            
        }
        
    }
    
    //imagino que irá retornar o menor valor entre dois caminhos por exemplo
    printf("retorno\n");
   return caminho;
}


int main(){
    
    scanf("%d %d", &n, &m);
    
    for(int i =0; i < m; i++){
        int s, t, b;
        scanf("%d %d %d", &s, &t, &b);
        vetor[3*i] = s; // inicio
        vetor[3*i+1] = t; // fim
        vetor[3*i+2] = b; // quantidade de buracos entre inicio e fim 
    }
    int resultado = resolve(0, n, m);
    printf("%d\n", resultado);
}
