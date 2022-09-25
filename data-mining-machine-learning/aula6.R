#Variavel categórica
v1 <- c(1,2,2,4) #num.
v1 <- as.factor(v1) #trasnf em variavel categorica
levels(v1)
levels(v1) <- c(levels(v1), "6")

#variaveis dummy no R
install.packages("dummies")
library(dummies)
m <- mtcars
m <- cbind(m, dummy(m$cyl)) #adicionando colunas ao dataframe

#Instalação do pacote confusion matrix
install.packages("caret")
install.packages("e1071")

#Tabela dinamica
install.packages("rpivotTable")
library(rpivotTable)
rpivotTable(dt)

#classificadores
#Arvores de decisão
#0. Pacotes utilizados
library(party)
library(caret)
library(e1071)

#1. Carda de dados
dt <- read.csv("https://raw.githubusercontent.com/diogenesjusto/FIAP/master/dados/train_titanic.csv")

#2. Tratamento de dados (feature eng.)
dt$Sex_f<- as.factor(dt$Sex)
dt$Pclass_f <- as.factor(dt$Pclass)

#3. Separação treino e teste
set.seed(33)
va <- sample(nrow(dt))
treino <- dt[va[1:600],]
teste <- dt[va[601:891],]

#4. Modelagem (árvore binária ctree)
mod <- ctree(Survived~Sex_f+Pclass_f+Age, data=treino)
plot (mod, type="simple")

#5. Previsão em teste
p <- predict(mod, newdata=teste)
#Ajuste fino no threshold (ponto de corte)
#Visando adequar distrib. de probabilidade esperada
prev <- ifelse(p<.45, 0, 1)

#6. Analise de previsões (classificador)
#Matriz de confusão
#table(prev, teste$Survived)
confusionMatrix(as.factor(prev), as.factor(teste$Survived))


