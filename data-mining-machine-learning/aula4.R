#Regressao Linear (usar até dez2014)
# 1. carga de dados
pib <- read.csv("https://raw.githubusercontent.com/diogenesjusto/FIAP/master/SHIFT/Data/pib.csv")

#2. split (separação base treino e teste)
treino <- pib[1:132,]
teste <- pib [133:138,] #a virgula é usada para filtrar colunas, como não vamos fitrar nada deixamos em branco

# 3. modelagem estatistica/machine learning
# 3.1 Regressão linear simples (uma variavel exógena)
#model1 <- lm(PIB~BRP, data=treino) #o ~ é utilizado para falar que tem outra variavel relacionada a primeira

# 3.2 Regressão linear multivariada (mais de uma variavel exógena)
#model1 <- lm(PIB~SPT+RJP, data=treino)

# 3.3 Modelo autoregressivo com ajuste de calda
model1 <- lm(PIB~PIBi1+PIBi2+PIBi4+PIBi12, data=treino)

# 3.4 Modelo multivariado com dummy de sazonalidade (ir tirando conforme os Pvalores)
model1 <- lm(PIB~BRP+BRL+D1+D2+D3+D4+D5+D6+D7+D8+D9+D10+D11, data=treino)


# 4. analise de regressão
#estatistica da regressão (P-value, Rquadrado e Erro Aprox)
summary(model1) #quando temos *** no p-value significa que é muito proximo de 0

# 5. previsao - pega um modelo e aplica em cima da base de teste
p <- predict(model1, newdata = teste)

# 6. erro de previsão (compara o previsto com o real)
cbind(teste$PIB,p, teste$PIB-p)

#metrica para erro de previsao
#tirar o problema de sinais negativos
#RMSE - abreviacao dos calculos (root mean squared error = raiz do erro quadrado médio)
#RMSE - é bom quero variar a qtde de observações pq ela tira uma média e não soma os valores
RMSE <- sqrt(mean((teste$PIB-p)^2)) 
#Sum of Squared Error - Pode ser util nos casos de valores muito pequenos
#é bom quando se tem o mesmo tamanho de base de teste, mas quando se tem valores muito distante não é bom fazer soma
SSE <- sum((teste$PIB-p)^2)
MSE