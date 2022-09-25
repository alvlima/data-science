#analise de conglomerados
m <- mtcars

#Visualização de 2 vars através do gráf. dispersão
plot(m$mpg~m$wt)

#calculo de kmeans (sorteio aleatorio dos k-centroides iniciais)
set.seed(33)

#calculo Kmeans
k <- kmeans(m[, c("mpg", "wt")], 7) #numero de clusters para visualização
#um metodo de escolha de k-centroides pode ser o metodo de elbow

#Visualização gráfica dos clusters
plot(m$mpg~m$wt, col=k$cluster, pch=k$cluster)

#"Normalização simples" - colocar na mesma ordem numerica da grandeza
m$wt_2 <- m$wt * 6
plot(m$mpg~m$wt_2, col=k$cluster, pch=k$cluster)


#Execução do k-means com as vars normalizadas
set.seed(33)
k <- kmeans(m[, c("mpg", "wt_2")], 4) #numero de clusters para visualização
plot(m$mpg~m$wt, col=k$cluster, pch=k$cluster)


#Resultado de um kmeans sendo aplicado em um metodo supervisionado
#1. Inicialmente sem o resultado do kmeans
summary(lm(mpg~wt, data=m))
#2. incluindo a nova variavel (o novo conhecimento) gerando a partir
#do clustering (simplificado)
summary(lm(mpg~wt + as.factor(k$cluster), data=m))



#1. Carda de dados
dt <- read.csv("https://raw.githubusercontent.com/diogenesjusto/FIAP/master/dados/train_titanic.csv")

#2. Tratamento de dados (feature eng.)
dt$Sex_f<- as.factor(dt$Sex)
dt$Pclass_f <- as.factor(dt$Pclass)
med <- mean(dt[!is.na(dt$Age),]$Age) #aplica um filtro de tudo que não é nulo
dt[is.na(dt$Age),]$Age <- med #pega os valores missing e substitui pela média


#3. Separação treino e teste
set.seed(33)
va <- sample(nrow(dt))
treino <- dt[va[1:600],]
teste <- dt[va[601:891],]

#4. Modelagem (regressão logistica, através do parametro, family=binomial)
mod <- glm(Survived~Sex_f+Pclass_f+Age, data=treino, family = binomial())

#5. Previsão em teste
p <- predict(mod, newdata=teste)
#Ajuste fino no threshold (ponto de corte)
#Visando adequar distrib. de probabilidade esperada
prev <- ifelse(p<.4, 0, 1)

#6. Analise de previsões (classificador)
#Matriz de confusão
#table(prev, teste$Survived)
confusionMatrix(as.factor(prev), as.factor(teste$Survived))


#---------------
#Random Forest (package: randomForest)
#0. Pacotes utilizados
install.packages("randomForest")

library(caret)
library(randomForest)

#1. Carda de dados
dt <- read.csv("https://raw.githubusercontent.com/diogenesjusto/FIAP/master/dados/train_titanic.csv")

#2. Tratamento de dados (feature eng.)
dt$Sex_f<- as.factor(dt$Sex)
dt$Pclass_f <- as.factor(dt$Pclass)
med <- mean(dt[!is.na(dt$Age),]$Age) 
dt[is.na(dt$Age),]$Age <- med
dt$Survived_f <- as.factor(dt$Survived)

#3. Separação treino e teste
set.seed(33)
va <- sample(nrow(dt))
treino <- dt[va[1:600],]
teste <- dt[va[601:891],]

#4. Modelagem (Random Forest)
mod <- randomForest(Survived_f~Sex_f+Pclass_f+Age, data=treino, ntree=500)
#analise de importancia de variaveis para randomForest
varImpPlot(mod)
#analise do "tamanho da floresta" como ajuste fino
plot(mod)

#5. Previsão em teste
prev <- predict(mod, newdata=teste)

#6. Analise de previsões (classificador)
#Matriz de confusão
#table(prev, teste$Survived)
confusionMatrix(as.factor(prev), as.factor(teste$Survived))
