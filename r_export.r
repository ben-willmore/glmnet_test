library(glmnet)

# basic glmnet
data(QuickStartExample)
x <- QuickStartExample$x
y <- QuickStartExample$y

fit <- glmnet(x, y)

dir.create('quickstart')
write.csv(x, 'quickstart/QuickStartExample_x.csv', row.names = FALSE)
write.csv(y, 'quickstart/QuickStartExample_y.csv', row.names = FALSE)
write.csv(fit$lambda, 'quickstart/QuickStartExample_lambda.csv', row.names = FALSE)
write.csv(fit$a, 'quickstart/QuickStartExample_a.csv', row.names = FALSE)
write.csv(fit$dev, 'quickstart/QuickStartExample_dev.csv', row.names = FALSE)
write.csv(fit$df, 'quickstart/QuickStartExample_df.csv', row.names = FALSE)
write.csv(fit$nulldev, 'quickstart/QuickStartExample_nulldev.csv', row.names = FALSE)
write.csv(as.data.frame(as.matrix(fit$beta)), 'quickstart/QuickStartExample_beta.csv', row.names = FALSE)


# cvglmnet
foldid <- c(rep(1,20), rep(2,20), rep(3,20), rep(4,20), rep(5,20))
cvfit <- cv.glmnet(x, y, foldid=foldid)

dir.create('quickstart-cvglmnet')
write.csv(x, 'quickstart-cvglmnet/QuickStart_cvglmnet_x.csv', row.names = FALSE)
write.csv(y, 'quickstart-cvglmnet/QuickStart_cvglmnet_y.csv', row.names = FALSE)
write.csv(foldid, 'quickstart-cvglmnet/QuickStart_cvglmnet_foldid.csv', row.names = FALSE)
write.csv(cvfit$lambda.min, 'quickstart-cvglmnet/QuickStart_cvglmnet_lambdamin.csv', row.names = FALSE)
write.csv(cvfit$lambda.1se, 'quickstart-cvglmnet/QuickStart_cvglmnet_lambda1se.csv', row.names = FALSE)
write.csv(cvfit$lambda, 'quickstart-cvglmnet/QuickStart_cvglmnet_lambda.csv', row.names = FALSE)
write.csv(cvfit$cvm, 'quickstart-cvglmnet/QuickStart_cvglmnet_cvm.csv', row.names = FALSE)
write.csv(cvfit$cvsd, 'quickstart-cvglmnet/QuickStart_cvglmnet_cvsd.csv', row.names = FALSE)
write.csv(cvfit$cvup, 'quickstart-cvglmnet/QuickStart_cvglmnet_cvup.csv', row.names = FALSE)
write.csv(cvfit$cvlo, 'quickstart-cvglmnet/QuickStart_cvglmnet_cvlo.csv', row.names = FALSE)
write.csv(cvfit$nzero, 'quickstart-cvglmnet/QuickStart_cvglmnet_nzero.csv', row.names = FALSE)

# poisson
data(PoissonExample)
x <- PoissonExample$x
y <- PoissonExample$y

fit <- glmnet(x, y, family = "poisson")

dir.create('poisson')
write.csv(x, 'poisson/PoissonExample_x.csv', row.names = FALSE)
write.csv(y, 'poisson/PoissonExample_y.csv', row.names = FALSE)
write.csv(fit$lambda, 'poisson/PoissonExample_lambda.csv', row.names = FALSE)
write.csv(fit$a, 'poisson/PoissonExample_a.csv', row.names = FALSE)
write.csv(fit$dev, 'poisson/PoissonExample_dev.csv', row.names = FALSE)
write.csv(fit$df, 'poisson/PoissonExample_df.csv', row.names = FALSE)
write.csv(fit$nulldev, 'poisson/PoissonExample_nulldev.csv', row.names = FALSE)
write.csv(as.data.frame(as.matrix(fit$beta)), 'poisson/PoissonExample_beta.csv', row.names = FALSE)

# poisson cvglmnet
foldid <- c(rep(1,100), rep(2,100), rep(3,100), rep(4,100), rep(5,100))
cvfit <- cv.glmnet(x, y, family = "poisson", foldid=foldid)

dir.create('poisson-cvglmnet')
write.csv(x, 'poisson-cvglmnet/poisson_cvglmnet_x.csv', row.names = FALSE)
write.csv(y, 'poisson-cvglmnet/poisson_cvglmnet_y.csv', row.names = FALSE)
write.csv(foldid, 'poisson-cvglmnet/PoissonExample_foldid.csv', row.names = FALSE)
write.csv(cvfit$lambda.min, 'poisson-cvglmnet/poisson_cvglmnet_lambdamin.csv', row.names = FALSE)
write.csv(cvfit$lambda.1se, 'poisson-cvglmnet/poisson_cvglmnet_lambda1se.csv', row.names = FALSE)
write.csv(cvfit$lambda, 'poisson-cvglmnet/poisson_cvglmnet_lambda.csv', row.names = FALSE)
write.csv(cvfit$cvm, 'poisson-cvglmnet/poisson_cvglmnet_cvm.csv', row.names = FALSE)
write.csv(cvfit$cvsd, 'poisson-cvglmnet/poisson_cvglmnet_cvsd.csv', row.names = FALSE)
write.csv(cvfit$cvup, 'poisson-cvglmnet/poisson_cvglmnet_cvup.csv', row.names = FALSE)
write.csv(cvfit$cvlo, 'poisson-cvglmnet/poisson_cvglmnet_cvlo.csv', row.names = FALSE)
write.csv(cvfit$nzero, 'poisson-cvglmnet/poisson_cvglmnet_nzero.csv', row.names = FALSE)

# logistic
data(BinomialExample)
x <- BinomialExample$x
y <- BinomialExample$y

fit <- glmnet(x, y, family = "binomial")

dir.create('binomial')
write.csv(x, 'binomial/BinomialExample_x.csv', row.names = FALSE)
write.csv(y, 'binomial/BinomialExample_y.csv', row.names = FALSE)
write.csv(fit$lambda, 'binomial/BinomialExample_lambda.csv', row.names = FALSE)
write.csv(fit$a, 'binomial/BinomialExample_a.csv', row.names = FALSE)
write.csv(fit$dev, 'binomial/BinomialExample_dev.csv', row.names = FALSE)
write.csv(fit$df, 'binomial/BinomialExample_df.csv', row.names = FALSE)
write.csv(fit$nulldev, 'binomial/BinomialExample_nulldev.csv', row.names = FALSE)
write.csv(as.data.frame(as.matrix(fit$beta)), 'binomial/BinomialExample_beta.csv', row.names = FALSE)

# binomial cvglmnet
foldid <- c(rep(1,20), rep(2,20), rep(3,20), rep(4,20), rep(5,20))
cvfit <- cv.glmnet(x, y, family = "binomial")

dir.create('binomial-cvglmnet')
write.csv(x, 'binomial-cvglmnet/binomial_cvglmnet_x.csv', row.names = FALSE)
write.csv(y, 'binomial-cvglmnet/binomial_cvglmnet_y.csv', row.names = FALSE)
write.csv(foldid, 'binomial-cvglmnet/binomial_cvglmnet_foldid.csv', row.names = FALSE)
write.csv(cvfit$lambda.min, 'binomial-cvglmnet/binomial_cvglmnet_lambdamin.csv', row.names = FALSE)
write.csv(cvfit$lambda.1se, 'binomial-cvglmnet/binomial_cvglmnet_lambda1se.csv', row.names = FALSE)
write.csv(cvfit$lambda, 'binomial-cvglmnet/binomial_cvglmnet_lambda.csv', row.names = FALSE)
write.csv(cvfit$cvm, 'binomial-cvglmnet/binomial_cvglmnet_cvm.csv', row.names = FALSE)
write.csv(cvfit$cvsd, 'binomial-cvglmnet/binomial_cvglmnet_cvsd.csv', row.names = FALSE)
write.csv(cvfit$cvup, 'binomial-cvglmnet/binomial_cvglmnet_cvup.csv', row.names = FALSE)
write.csv(cvfit$cvlo, 'binomial-cvglmnet/binomial_cvglmnet_cvlo.csv', row.names = FALSE)
write.csv(cvfit$nzero, 'binomial-cvglmnet/binomial_cvglmnet_nzero.csv', row.names = FALSE)
