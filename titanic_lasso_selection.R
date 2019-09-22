library(glmnet)
df <- read.csv('/Users/charliejones/documents/rstuff/featsele/train.csv')
attach(df)

y <- df['Survived']
x <- df[ , !(names(df) %in% 'Survived')]
x <- df[ , -which((names(df)) %in% c("Name","PassengerId","Ticket","Cabin","Embarked"))]

x$Age[is.na(x$Age)] <- mean(x$Age, na.rm=TRUE)

x <- data.matrix(x)
factor_y <- factor(Survived)
#Lasso pPenalty
glmnet_v1 <- cv.glmnet(x, factor_y, family='binomial', type.measure = 'class',
                           alpha=1,nlambda = 100)
#Ridge Penalty
glmnet_v2 <- cv.glmnet(x,factor_y,family='binomial',type.measure = 'class',alpha=0)

plot(glmnet_v1)
plot(glmnet_v2)
coef(glmnet_v1, s = "lambda.1se")
as.matrix(coef(glmnet_v2, glmnet_v2$lambda.1se))
