#0. Pacotes utilizados
library(dummies)
library(corrplot)
library(xlsx)

#1. Carda de dados
baba <- read.csv("https://raw.githubusercontent.com/diogenesjusto/FIAP/master/SHIFT/desafio/baba/BABA.csv")
dolar <- read.xlsx("USD_BRL Dados Históricos.xlsx", sheetIndex = 1)

#2. Tratamento de dados (feature eng.)
baba <- cbind(baba, dolar)

baba[baba$mes == 'mar?o',]$mes = 'marco'
baba[baba$weekday == 'quarta-feira',]$weekday = 'quarta'
baba[baba$weekday == 'quinta-feira',]$weekday = 'quinta'
baba[baba$weekday == 'segunda-feira',]$weekday = 'segunda'
baba[baba$weekday == 'sexta-feira',]$weekday = 'sexta'
baba[baba$weekday == 'terca-feira',]$weekday = 'terca'

baba <- cbind(baba, dummy(baba$mes))#adicionando colunas ao dataframe
baba <- cbind(baba, dummy(baba$weekday))

baba$desconto_f<- as.factor(baba$desconto)
baba$venda_f <- as.factor(baba$venda)
baba$dolar_f <- as.factor(baba$dolar)
baba$weekday_f <-as.factor(baba$weekday)



#3. Separação treino e teste
treino <- baba[1:365,]
teste  <- baba[366:396,]

#4.1 Modelagem (regressão linear)
mod <- lm(venda~desconto+dolar+babaagosto+babasetembro
          +babaoutubro+babadomingo
          +babasabado+babasegunda, data=treino)
summary(mod)

mod2 <- lm(venda~desconto+dolar+babajaneiro+babafevereiro+babamarco
           +babaabril+babamaio+babajunho+babajulho+babaagosto
           +babasetembro+babaoutubro+babanovembro+babadezembro
           , data=treino)
summary(mod2)

mod3 <- lm(venda~desconto+dolar+babadomingo
          +babasabado+babasegunda, data=treino)
summary(mod3)

#5. Previsão em teste
p <- predict(mod, newdata=teste)

#6. Analise de previsões (classificador)
#Matriz de confusão
#table(prev, teste$Survived)
RMSE <- sqrt(mean((teste$venda-p)^2)) 

cor.test(treino$venda, treino$dolar)


#Criação do arquivo para submissão
df <- as.data.frame(cbind(1:31,p))
names(df)<-c("id","venda")
write.table(df, 'predict.csv', row.names = FALSE, col.names = FALSE, sep=",")