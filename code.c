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
    int caminho = 10000;
    int caminho1 = 10000;
    int estadoInicial = vetor[3*indice];
    int estadoFinal = vetor[3*indice + 1];
    int buracos = vetor[3*indice +2];
    
    int i = indice+1;
    
    while(vetor[3*i+1] != final){
        if (vetor[3*i] == estadoFinal){
            caminho = buracos + vetor[3*i+2];
        }else if (vetor[3*i] == estadoInicial ){
            caminho1 = resolve(i, final, quantidadePontes);
        }
        i++;
    }
    
    return min(caminho,caminho1);
   
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
    int resultado = resolve(0, n+1, m);
    printf("%d\n", resultado);
}
