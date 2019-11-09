library(pROC)


data <- read.csv("checkpoints/fine_tuning/test_results.tsv", sep = "\t", 
    header = F)
print(head(data))
sentences <- data[,1]
y <- data[,2] == "AE"
y_hat_p <- data[,4]
y_hat <- y_hat_p >= 0.5
print(data[is.na(y_hat),])
print(summary(y))
print(summary(y_hat))
accuracy <- mean(y == y_hat)
tp <- sum((y == y_hat) & y_hat)
fp <- sum((y != y_hat) & y_hat)
tn <- sum((y == y_hat) & !y_hat)
fn <- sum((y != y_hat) & !y_hat)
precision = tp / (tp + fp)
recall = tp / (tp + fn)
specificity = tn / (tn + fp)
auc <- auc(roc(y, y_hat_p))
cat(sprintf("True Positives: %d\n", tp))
cat(sprintf("False Positives: %d\n", fp))
cat(sprintf("True Negatives: %d\n", tn))
cat(sprintf("False Negatives: %d\n", fn))
cat(sprintf("Accuracy: %.3f\n", accuracy))
cat(sprintf("Precision: %.3f\n", precision))
cat(sprintf("Recall: %.3f\n", recall))
cat(sprintf("Specificity: %.3f\n", specificity))
print(auc)
