#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <float.h>


// 1
/* int main() 
{
    int num;
    int max;
    int first_input = 1;
    
    while (1)
    {
        scanf("%d", &num); 
        
        if (num == 0) 
        {
            break;
        }

        if (first_input)
        {
            max = num;
            first_input = 0;
        }
        else if (num >= max)
        {
            max = num;
        }
    }

    if (!first_input)
    {
        printf("O máximo é: %d\n", max);
    }
    else 
    {
        printf("Nenhum elemento foi inserido\n");
    }
    
    return 0;
} */

// 2
/* int main() 
{
    int num;
    float avg = 0.0;
    int counter = 0;
    int first_input = 1;
    
    while (1)
    {
        scanf("%d", &num); 
        
        if (num == 0) 
        {
            break;
        }

        counter++;
        avg += num;
        first_input = 0;
    }

    if (!first_input)
    {
        printf("A média é: %.2f\n", avg/counter);
    }
    else 
    {
        printf("Nenhum elemento foi inserido\n");
    }
    
    return 0;
} */

// 3
/* int main() 
{
    int num;
    int max;
    int max2;
    int first_input = 1;
    
    while (1)
    {
        scanf("%d", &num); 
        
        if (num == 0) 
        {
            break;
        }

        if (first_input)
        {
            max = num;
            first_input = 0;
        }
        else if (num >= max)
        {
            max2 = max;
            max = num;
        }
    }

    if (!first_input)
    {
        printf("O segundo maior é: %d\n", max2);
    }
    else 
    {
        printf("Nenhum elemento foi inserido\n");
    }
    
    return 0;
}  */

// 4
/* unsigned int binarioParaDecimal(const char *bin) // Aux to see display
{
    unsigned int decimal = 0;
    while (*bin) 
    {
        decimal = (decimal << 1) + (*bin++ - '0');
    }
    return decimal;
}

int bitsUm(unsigned int n) 
{
    int count = 0;
    while (n) 
    {
        count += n & 1;
        n >>= 1;
    }
    return count;
}

int main() 
{
    char bin[33];
    printf("Digite um numero binario: ");
    scanf("%32s", bin);  // Lê até 32 bits
    
    unsigned int num = binarioParaDecimal(bin);
    printf("O numero de bits iguais a 1 em %s e: %d\n", bin, bitsUm(num));
    
    return 0;
} */

// 5
int trailingZ(unsigned int n)
{
    if (n == 0) return 32; 
    
    unsigned int count = 0;
    while ((n & 1) == 0) 
    { 
        count++;
        n >>= 1; 
    }
    return count;
}

// 6
int qDig (unsigned int n)
{
    if (n == 0) return 1;

    int count = 0;
    while (n > 0)
    {
        count++;
        n /= 10;
    }

    return count;
}

/* int main()
{
    int x = 0;
    x = qDig(152445454);

    printf("%d\n", x);
} */

// 7
char *mystrcat (char s1[], char s2[])
{
    char aux [strlen(s1) + strlen(s2)];
    int i,j;

    for (i = 0; s1[i] != '\0'; i++)
    {
        aux[i] = s1[i];
    }

    for (j = 0; s2[j] != '\0'; j++)
    {
        aux[i] = s2[j];
        i++;
    }

    strcpy(s1, aux);

    return s1;
}

// 8
char *mystrcpy (char *dest, char source[])
{
    int i;
    for (i = 0; source[i] != '\0'; i++)
    {
        dest[i] = source[i];
    }
    dest[i] = '\0';

    return dest;
}


// 9
int mystrcmp(char s1[], char s2[]) 
{
    int i = 0;
    while (s1[i] != '\0' && s2[i] != '\0') 
    {
        if (s1[i] != s2[i]) 
        {
            return (s1[i] > s2[i]) ? 1 : -1;
        }
        i++;
    }

    if (s1[i] == '\0' && s2[i] == '\0') 
    {
        return 0;  
    } 
    else if (s1[i] == '\0') 
    {
        return -1;
    } 
    else 
    {
        return 1; 
    }
}

// 10
char *mystrstr (char s1[], char s2[])
{
    if (s2[0] == '\0') return s1;

    for (int i = 0; s1[i] != '\0'; i++)
    {
        int j = 0;
        while (s1[i + j] == s2[j] && s2[j] != '\0')
        {
            j++;
        }

        if (s2[j] == '\0')
        {
            return &s1[i];
        }
    }
    
    return NULL;
}

// 11
void mystrrev (char s[])
{
    int tam =  strlen(s);
    char aux[tam + 1];
    int j = 0;
    for (int i = tam - 1; i >= 0; i--)
    {
        aux[j] = s[i];
        j++;
    }

    aux[j] = '\0';

    for (j = 0; aux[j] != '\0'; j++)
    {
        s[j] = aux[j];
    }

    s[j] = '\0';
}

// ou (sem string auxiliar)
void strrev_inplace(char s[]) 
{
    int i = 0, j = strlen(s) - 1;
    char temp;
    
    while (i < j) 
    {
        temp = s[i];
        s[i] = s[j];
        s[j] = temp;
        i++;
        j--;
    }
}

// 12
int isVogal(char c) 
{
    c = tolower(c);
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

void strnoV (char s[])
{
    int tam = strlen(s);
    char aux[tam + 1];
    int i, j = 0;

    for (i = 0; s[i] != '\0'; i++)
    {
        if (!isVogal(s[i])) 
        {
            aux[j] = s[i];
            j++;
        } 
    }

    aux[j] = '\0';

    for (i = 0; aux[i] != '\0'; i++)
    {
        s[i] = aux[i];
    }

    s[i] = '\0';
}

// 13
void truncW(char t[], int n) 
{
    int i = 0, j = 0, count = 0;

    while (t[i] != '\0') 
    {
        count = 0;
        while (t[i] != '\0' && t[i] != ' ' && count < n) 
        {
            t[j++] = t[i++];
            count++;
        }

        while (t[i] != '\0' && t[i] != ' ') 
        {
            i++;
        }

        if (t[i] == ' ') 
        {
            t[j++] = t[i++];
        }
    }

    t[j] = '\0';
}

// 14
char charMaisfreq (char s[])
{
    if (s[0] == '\0') return 0;

    int counter[256] = {0};
    int maxCounter = 0;
    char maxChar = 0;

    for (int i = 0; s[i] != '\0'; i++)
    {
        counter[s[i]]++;
        if (counter[s[i]] > maxCounter)
        {
            maxCounter = counter[s[i]];
            maxChar = s[i];
        }
    }

    return maxChar;
}

// 15
int iguaisConsecutivos (char s[])
{
    if (s[0] == '\0') return 0;

    int maxConsec = 1;
    int consec = 1;
    for (int i = 0; s[i] != '\0'; i++)
    {
        if (s[i] == s[i+1])
        {
            consec++;
            if (consec > maxConsec) maxConsec = consec;
        }
        else 
        {
            consec = 1;
        }
    }

    return maxConsec;
}

// 16
#include <stdio.h>
#include <string.h>

int difConsecutivos(char s[]) 
{
    if (s[0] == '\0') return 0;

    int maxDif = 0;
    int start = 0;
    int visto[256] = {0}; 
    
    for (int end = 0; s[end] != '\0'; end++) 
    {
        char ch = s[end];
        while (visto[ch]) 
        {
            visto[s[start]] = 0;
            start++;
        }

        visto[ch] = 1;
        
        if (end - start + 1 > maxDif) 
        {
            maxDif = end - start + 1;
        }
    }

    return maxDif;
}

// 17
int maiorPrefixo (char s1 [], char s2 [])
{
    int i;
    for (i = 0; s1[i] != '\0' && s2[i] != '\0' && s1[i] == s2[i]; i++);
    
    return i;
}

// 18
int maiorSufixo(char s1[], char s2[]) {
    int conta = 0;
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    for (int i = len1 - 1, j = len2 - 1; i >= 0 && j >= 0; i--, j--) {
        if (s1[i] == s2[j]) {
            conta++;
        } else {
            break;  // Para ao encontrar o primeiro caractere diferente
        }
    }

    return conta;
}

// 19
int sufPref (char s1[], char s2[])
{
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int minLen = (len1 < len2) ? len1 : len2;

    for (int i = 0; i < minLen; i++)
    {
        int corresponde = 1;
        for (int j = 0; j <= i; j++)
        {
            if (s1[len1 -i -1 + j] != s2[j])
            {
                corresponde = 0;
                break;
            }
        }
        if (corresponde) return i + 1;
    }

    return 0;
}

// 20
int contaPal (char s[])
{
    int conta = 0;
    for (int i = 0; s[i] != '\0'; i++)
    {
        if (s[i] != ' ' && (i == 0 || s[i-1] == ' ')) conta++;
    }

    return conta;
}

// 21
int contaVogais(char s[])
{
    int conta = 0;
    for (int i = 0; s[i] != '\0'; i++)
    {
        char c = tolower(s[i]);
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'y') conta++;
    }

    return conta;
}

// 22
int contida (char s[], char b[])
{
    int len1 = strlen(s);
    int len2 = strlen(b);
    

    for (int i = 0; i < len1; i++)
    {
        int encontrou = 0;
        for (int j = 0; j < len2; j++)
        {
            if (s[i] == b[j])
            {
                 encontrou = 1;
                 break; 
            }
        }

        if (!encontrou) return 0;
    }

    return 1;
}

// 23
int palindorome (char s[])
{
    int tam = strlen(s);
    char aux[tam + 1];
    int i;

    for (i = 0; s[i] != '\0'; i++)
    {
        aux[i] = s[tam - 1];
        tam--;
    }
    aux[i] = '\0';

    for (i = 0; aux[i] != '\0'; i++)
    {
        if (aux[i] != s[i]) return 0;
    }

    return 1;
}

// 24
int remRep (char x[])
{
    char aux[strlen(x) + 1];
    int i, j = 0;
    
    for (i = 0; x[i] != '\0'; i++)
    {
        if (x[i] != x[i + 1])
        {
            aux[j] = x[i];
            j++;
        }
    }

    aux[j] = '\0';

    for (i = 0; aux[i] != '\0'; i++)
    {
        x[i] = aux[i];
    }

    x[i] = '\0';

    return 0;
}

// 25
int limpaEspacos (char t[])
{
    char aux[strlen(t) + 1];
    int i, j = 0;
    
    for (i = 0; t[i] != '\0'; i++)
    {
        if (t[i] != ' ' || (i > 0 && t[i-1] != ' '))
        {
            aux[j] = t[i];
            j++;
        }
    }

    aux[j] = '\0';

    for (i = 0; aux[i] != '\0'; i++)
    {
        t[i] = aux[i];
    }

    t[i] = '\0';

    return 0;
}

/* int main() {
    char str1[] = "ola";
    char str2[] = "bracara augusta";

    limpaEspacos(str1);
    printf("New string: %s\n", str1);

    return 0;
} */

// 26
void insere(int v[], int N, int x) 
{
    int i, j;

    for (i = 0; i < N; i++) 
    {
        if (v[i] > x) 
        {
            break;
        }
    }

    for (j = N; j > i; j--) 
    {
        v[j] = v[j - 1];
    }

    v[i] = x;
}

// 27
void swap (int v[], int i, int j)
{
    int temp = v[i];
    v[i] = v[j];
    v[j] = temp;
}

void bubbleSort (int v[], int N)
{
    for (int i = 0; i < N-1; i++)
    {
        for (int j = 0; j < N-i-1; j++)
        {
            if (v[j] >= v[j+1]) swap(v, j, j+1);
        }
    }
}

void merge (int r[], int a[], int b[], int na, int nb)
{
    for (int i = 0; i < na; i++)
    {
        r[i] = a[i];
    }

    for (int i = na; i < na + nb; i++)
    {
        r[i] = b[i-na];
    }

    bubbleSort(r, na+nb);
}

// mais eficiente
void merge2 (int r [], int a[], int b[], int na, int nb)
{
    int i = 0, j = 0, k = 0;

    while (i < na && j < nb)
    {
        if (a[i] < b[j])
        {
            r[k] = a[i];
            k++;
            i++;
        }
        else 
        {
            r[k] = b[j];
            k++;
            j++;
        }
    }

    while (i < na)
    {
        r[k] = a[i];
        k++;
        i++;
    }

    while (j < nb)
    {
        r[k] = b[j];
        k++;
        j++;
    }
}

/* int main() {
    int a[] = {1, 3, 5, 7, 8, 9, 15};  // Vetor ordenado A
    int b[] = {2, 4, 6, 8, 10}; // Vetor ordenado B
    int na = 7, nb = 5;
    int r[na + nb];

    merge2(r, a, b, na, nb);

    // Imprimir vetor resultado
    for (int i = 0; i < na + nb; i++) {
        printf("%d ", r[i]);
    }
    printf("\n");

    return 0;
} */

// 28
int crescente (int a[], int i, int j)
{
    for (int k = i; k < j; k++)
    {
        if (a[k] > a[k+1]) return 0;
    }

    return 1;
}

/* int main() {
    int a[] = {1, 3, 5, 7, 8, 9, 15};  // Vetor ordenado
    int b[] = {2, 4, 6, 5, 10};        // Vetor com um erro na ordem
    int na = 7, nb = 5;

    // Testando a função crescente
    printf("O vetor a está ordenado entre [0,6]? %s\n", crescente(a, 0, 6) ? "Sim" : "Não");
    printf("O vetor b está ordenado entre [0,4]? %s\n", crescente(b, 0, 4) ? "Sim" : "Não");
    printf("O vetor a está ordenado entre [2,5]? %s\n", crescente(a, 2, 5) ? "Sim" : "Não");
    printf("O vetor b está ordenado entre [0,2]? %s\n", crescente(b, 0, 2) ? "Sim" : "Não");

    return 0;
} */

// 29
int retiraNeg (int v[], int N)
{
    int aux[N];
    int j = 0;

    for (int i = 0; i < N; i++)
    {
        if (v[i] >= 0)
        {
            aux[j] = v[i];
            j++;
        }
    }

    for (int i = 0; i < N; i++)
    {
        v[i] = aux[i];
    }

    return j;
}

// mais eficiente
int retiraNeg2 (int v[], int N)
{
    int j = 0;

    for (int i = 0; i < N; i++)
    {
        if (v[i] >= 0)
        {
            v[j] = v[i];
            j++;
        }
    }

    return j;
}

/* void printArray(int v[], int N) {
    for (int i = 0; i < N; i++) {
        printf("%d ", v[i]);
    }
    printf("\n");
}

int main() {
    int v1[] = {1, -3, 5, -7, 8, -2, 9, 15};  
    int v2[] = {1, -3, 5, -7, 8, -2, 9, 15};  
    int N = sizeof(v1) / sizeof(v1[0]);

    printf("Vetor original: ");
    printArray(v1, N);

    // Testando a versão menos eficiente
    int newSize1 = retiraNeg(v1, N);
    printf("Vetor após retiraNeg: ");
    printArray(v1, newSize1);

    // Testando a versão otimizada
    int newSize2 = retiraNeg2(v2, N);
    printf("Vetor após retiraNeg2 (otimizado): ");
    printArray(v2, newSize2);

    return 0;
} */

// 30
int menosFreq(int v[], int N) 
{
    int minConta = N + 1;
    int freqMenor = -1;  

    for (int i = 0; i < N; i++) 
    {
        if (v[i] == -1) continue;  

        int conta = 1;

        for (int j = i + 1; j < N; j++) 
        {
            if (v[j] == v[i]) 
            {
                conta++;
                v[j] = -1;  
            }
        }

        if (conta < minConta) 
        {
            minConta = conta;
            freqMenor = v[i];  
        }

        if (minConta == 1) 
        {
            break;
        }
    }

    return freqMenor;
}

/* int main() {
    int v1[] = {1, 1, 2, 2, 2, 3, 4, 4, 5, 5, 5};  
    int v2[] = {10, 10, 10, 20, 20, 30, 40, 40, 40, 40};  
    int v3[] = {7, 7, 7, 7, 7};  
    int v4[] = {5, 5, 5, 6};  

    int N1 = sizeof(v1) / sizeof(v1[0]);
    int N2 = sizeof(v2) / sizeof(v2[0]);
    int N3 = sizeof(v3) / sizeof(v3[0]);
    int N4 = sizeof(v4) / sizeof(v4[0]);

    printf("Menos frequente em v1: %d\n", menosFreq(v1, N1)); // Deve retornar 3
    printf("Menos frequente em v2: %d\n", menosFreq(v2, N2)); // Deve retornar 20
    printf("Menos frequente em v3: %d\n", menosFreq(v3, N3)); // Deve retornar 7
    printf("Menos frequente em v4: %d\n", menosFreq(v4, N4)); // Deve retornar 6

    return 0;
} */

int maisFreq (int v[], int N)
{
    int maxConta = 0;
    int mf = -1;

    for (int i = 0; i < N; i++)
    {
        int conta = 1;

        for (int j = i + 1; j < N; j++)
        {
            if (v[j] == v[i])
            {
                conta++;
            }
        }

        if (conta > maxConta) 
        {
            maxConta = conta;
            mf = v[i];
        }
    }

    return mf;
}

// 32
int maxCresc (int v[], int N)
{
    int conta = 1, maxConta = 0;
    for (int i = 0; i < N; i++)
    {
        if (v[i+1] > v[i])
        {
            conta++;
        }
        else if (conta > maxConta)
        {
            maxConta = conta;
        }
        else
        {
            conta = 1;
        }
    }

    return maxConta;
}


/* int main()
{
    int v[] = {1, 2, 3, 2, 1, 4, 2, 4, 5, 4};
    int N = 10;

    int resultado = maxCresc(v, N);

    printf("A maior sequência crecente é de: %d elementos\n", resultado);
    for (int i = 0; i < N; i++)
    {
        printf ("%d\n", v[i]);
    }

    return 0;
} */

// 33
int elimRep(int v[], int n) 
{
    if (n == 0) return 0;

    int pos = 1; 

    for (int i = 1; i < n; i++) 
    {
        int j;
        for (j = 0; j < pos; j++)
        {
            if (v[i] == v[j]) 
            {
                break; 
            }
        }
        
        if (j == pos) 
        {
            v[pos] = v[i];
            pos++;
        }
    }
    
    return pos; 
}

// 34
int elimRepOrd (int v[], int n)
{
    int removed = 0, pos = 1;
    for (int i = 1; i < n; i++)
    {
        if (v[i] != v[i-1])
        {
            v[pos] = v[i];
            pos++;
        }
    }

    return pos;
}

// 35
int comunsOrd(int a[], int na, int b[], int nb) 
{
    int comuns = 0;

    for (int i = 0, j = 0; i < na && j < nb;) 
    {
        if (a[i] == b[j])
        {    
            comuns++;
            i++; j++;          
        } 
        else if (a[i] < b[j]) 
        {
            i++;              
        } 
        else 
        {
            j++;               
        }
    }

    return comuns;
}

// 36
int comuns(int a[], int na, int b[], int nb) 
{
    int comuns = 0;
    int contados[nb];  

    for (int i = 0; i < nb; i++) 
    {
        contados[i] = 0;
    }

    for (int i = 0; i < na; i++) 
    {
        for (int j = 0; j < nb; j++) 
        {
            if (a[i] == b[j] && contados[j] == 0) 
            { 
                comuns++;
                contados[j] = 1; 
                break;  
            }
        }
    }

    return comuns;
}

// 37
int minInd (int v[], int n)
{
    int ind = 0;
    int min = v[0];
    for (int i = 1; i < n; i++)
    {
        if (v[i] < min)
        {
            min = v[i];
            ind = i;
        }
    }

    return ind;
}

// 38 
void somasAc (int v[], int Ac [], int N)
{
    Ac[0] = v[0];
    for (int i = 1; i < N; i++)
    {
        Ac[i] = Ac[i-1] + v[i];
    }
}

/* int main() 
{
    int a[] = {1, 2, 3, 4, 5};  
    int b[] = {3, 4, 5, 6, 7};  
    int na = sizeof(a) / sizeof(a[0]); 
    int nb = sizeof(b) / sizeof(b[0]); 

    printf("Vetor a: ");
    for (int i = 0; i < na; i++) 
    {
        printf("%d ", a[i]);
    }
    printf("\n");

    printf("Vetor b: ");
    for (int i = 0; i < nb; i++) 
    {
        printf("%d ", b[i]);
    }
    printf("\n");

    int resultado = comuns(a, na, b, nb); 

    printf("Número de elementos comuns: %d\n", resultado); 

    return 0;
} */

// 39
int triSup (int N, float m [N][N])
{
    for (int i = 1; i < N; i++)
    {
        for (int j = 0; j < i; j++)
        {
            if (m[i][j] != 0)
            {
                return 0;
            }   
        }
    }

    return 1;    
}

// 40
void transposta (int N, float m [N][N])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = i + 1; j < N; j++)
        {
            float temp = m[i][j];
            m[i][j] = m[j][i];
            m[j][i] = temp;
        }
    }
}

// 41
void addTo (int N, int M, int a [N][M], int b[N][M])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < M; j++)
        {
            a[i][j] += b[i][j];
        }
    }
}

// 42
int unionSet (int N, int v1[N], int v2[N], int r[N])
{
    for (int i = 0; i < N; i++)
    {
        if (v1[i] == 1 || v2[i] == 1)
        {
            r[i] = 1;
        }
        else 
        {
            r[i] = 0;
        }
    }

    return 0;
}

// 43
int intersectSet (int N, int v1[N], int v2[N], int r[N])
{
    for (int i = 0; i < N; i++)
    {
        if (v1[i] == 1 && v2[i] == 1)
        {
            r[i] = 1;
        }
        else 
        {
            r[i] = 0;
        }
    }

    return 0;
}

// 44
int intersectMSet (int N, int v1[N], int v2[N], int r[N])
{
    for (int i = 0; i < N; i++)
    {
        if (v1[i] != 0 && v2[i] != 0)
        {
            if (v1[i] < v2[i])
            {
                r[i] = v1[i];
            }
            else
            {
                r[i] = v2[i];
            }
        }
        else 
        {
            r[i] = 0;
        }   
    }

    return 0;
}

// 45
int unionMSet (int N, int v1[N], int v2[N], int r[N])
{
    for (int i = 0; i < N; i++)
    {
        r[i] = v1[i] + v2[i];
    }

    return 0;
}

// 46
int cardinalMSet (int N, int v[N])
{
    int soma = 0;
    for (int i = 0; i < N; i++)
    {
        soma += v[i];
    }

    return soma;
}

// 47
typedef enum movimento {Norte, Oeste, Sul, Este} Movimento;
typedef struct posicao 
{
    int x, y;
} Posicao;

Posicao posFinal (Posicao inicial, Movimento mov[], int N)
{
    Posicao final = inicial;
    for (int i = 0; i < N; i++)
    {
        if (mov[i] == Norte)
        {
            final.y += 1;
        }
        else if (mov[i] == Sul)
        {
            final.y -= 1;
        }
        else if (mov[i] == Oeste)
        {
            final.x -= 1;
        }
        else if (mov[i] == Este)
        {
            final.x += 1;
        }
    }

    return final;
}

// 48
int caminho (Posicao inicial, Posicao final, Movimento mov[], int N)
{
    int diferencaX = final.x - inicial.x;
    int diferencaY = final.y - inicial.y;
    int i;

    for (i = 0; i < N; i++)
    {
        if (diferencaX > 0)
        {
            mov[i] = Este;
            diferencaX--;
        }
        else if (diferencaX < 0)
        {
            mov[i] = Oeste;
            diferencaX++;
        }
        else if (diferencaY > 0)
        {
            mov[i] = Norte;
            diferencaY--;
        }
        else if (diferencaY < 0)
        {
            mov[i] = Sul;
            diferencaY++;
        }

        if (diferencaX == 0 && diferencaY == 0)
        {
            return i + 1;  
        }
    }

    return -1;
}

// 49
int maisCentral (Posicao pos[], int N)
{
    float dist;
    float minDist = FLT_MAX;
    int minInd = 0;

    for (int i = 0; i < N; i++)
    {
        dist = sqrt(pow (pos[i].x, 2) + pow (pos[i].y, 2));

        if (minDist > dist)
        {
            minDist = dist;
            minInd = i;
        }
    }

    return minInd;
}

// 50
int vizinhos (Posicao p, Posicao pos[], int N)
{
    float dist = FLT_MAX;
    int count = 0;
    for (int i = 0; i < N; i++)
    {
        dist = sqrt(pow ((pos[i].x - p.x), 2) + pow ((pos[i].y - p.y), 2));
        if (dist <= 1) count++;
    }

    return count;
}

int main() 
{
    float matriz1[3][3] = 
    {
        {1, 2, 3},
        {0, 5, 6},
        {0, 0, 9}
    };

    float matriz2[3][3] = 
    {
        {1, 2, 3},
        {4, 5, 6},
        {0, 0, 9}
    };

    printf("Matriz 1: %s\n", triSup(3, matriz1) ? "Triangular Superior" : "Não Triangular Superior");
    printf("Matriz 2: %s\n", triSup(3, matriz2) ? "Triangular Superior" : "Não Triangular Superior");
    
    transposta(3, matriz1);
    printf("\nMatriz 1 transposta:\n");
    for (int i = 0; i < 3; i++) 
    {
        for (int j = 0; j < 3; j++) 
        {
            printf("%.2f ", matriz1[i][j]);
        }
        printf("\n");
    }
    
    int mat1[2][2] = 
    {
        {1, 2},
        {3, 4}
    };
    
    int mat2[2][2] = 
    {
        {5, 6},
        {7, 8}
    };
    
    addTo(2, 2, mat1, mat2);
    printf("\nMatriz 1 após adição:\n");
    for (int i = 0; i < 2; i++) 
    {
        for (int j = 0; j < 2; j++) 
        {
            printf("%d ", mat1[i][j]);
        }
        printf("\n");
    }
    
    int v1[8] = {0, 2, 0, 0, 1, 0, 0, 3};
    int v2[8] = {1, 1, 1, 0, 0, 2, 1, 2};
    int r[8];
    
    unionSet(8, v1, v2, r);
    printf("\nUnião dos conjuntos:\n");
    for (int i = 0; i < 8; i++) 
    {
        printf("%d ", r[i]);
    }
    printf("\n");
    
    intersectSet(8, v1, v2, r);
    printf("\nInterseção dos conjuntos:\n");
    for (int i = 0; i < 8; i++) 
    {
        printf("%d ", r[i]);
    }
    printf("\n");
    
    intersectMSet(8, v1, v2, r);
    printf("\nInterseção dos multi-conjuntos:\n");
    for (int i = 0; i < 8; i++) 
    {
        printf("%d ", r[i]);
    }
    printf("\n");
    
    return 0;
}

// mains estão incompletas, apenas testam algumas funções
// se precisar de testar alguma implementação que não tenha main
// associada, pedir ao GPT :)