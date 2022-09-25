m<-mtcars
m

head(m) #Visualização das primeiras 6 linhas de um dataframe

m$mpg #O $ é utilizado para acessar um atributo de um objeto
mean(m$mpg) #calculo de média
median(m$mpg) #calculo de mediana
max(m$mpg)-min(m$mpg) #calculo de amplitude
sd(m$mpg) #calculo de desvio padrão
plot(m$mpg) #gráfico

write.csv(m, file = "m.csv") #gravar os dados num arquivo
df <- read.csv("m.csv")

install.packages("ggplot2") #instalação de pacotes
library(ggplot2) #carregar na memória depois da instalação
#toda vez que for abrir o R studio para trabalhar só carregar o library(nome_pacote)

d<- diamonds #Dados de diamantes
head(d)

#descrever a população
mean(d$price)
median(d$price)
sd(d$price)

#obtenção da amostra (Os dados estão muito diferentes da população - tentar de novo)
#para dizermos que os dados estão parecidos a amostra e população devem ter uma variação de 3%
a1 <- d[1:3000,]
mean(a1$price)
median(a1$price)
sd(a1$price)

#obtenção da segunda amostra (também não deu certo - tentar de novo)
a2 <- d[3001:6000,]
mean(a2$price)
median(a2$price)
sd(a2$price)

#geração de um numero aleatório
#para conseguir reproduzir a mesma amostra aleatório devemos fazer set.seed()
set.seed(33)
sample(3)


#obtenção de dados para amostra de forma aleatória pq os dados são atemporais
#geração de um vetor de numeros aleatórios do tamanho da população
set.seed(33)
va <- sample(53940)
a3 <- d[va[1:3000],] #filtro para obter uma amostra aleatória
mean(a3$price)
median(a3$price)
sd(a3$price)

#como calcular um histograma - representação através do gráfico de barras
#demonstrando a distribuição dos dados
hist(d$price)
hist(a1$price)
hist(a2$price)
hist(a3$price)

#Parametro de janela de visualização
par(mfrow=c(2,2))

#Parametro resetado para o anterior
par(mfrow=c(1,1)) #podemos mexer com esses parametros conforme quisermos

#Comando para calcular algumas funções de estatistica descritiva sobre um dataset
summary(d)
summary(d$price)
summary(a1$price)
summary(a2$price)
summary(a3$price)

#BloxPlot
boxplot(d$price)

#boxplot - análise de segmentos
boxplot(d$price ~ d$cut)
boxplot(d$price~d$clarity)

#Gráfico de dispersão
plot(m$mpg ~ m$wt)
#coeficiente de correlação linear
cor(m$mpg, m$wt)

plot(m$mpg ~ m$hp)
cor(m$mpg, m$hp)

#Matriz de correlação
cor(m)

#homework
install.packages("swirl")
library(swirl)
swirl()
