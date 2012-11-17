sensspec <-
function(x, gold) {
    n0 = length(which(gold==0))
    n1 = length(which(gold==1))
    N = n0 + n1
    sensitivity = rep(NA, N)
    specificity = rep(NA, N)
    cutoff = rep(NA, N)
    sort.x = sort(x)
        for (i in 1:N) {
        cutoff[i] = sort.x[i]
        #welche Werte sind größer als der Cutoff#
        index = which(x>cutoff[i])
        #Allocation: gibt an, welche Werte beim obigen Cut-Off als gesund oder krank gelten
        allocation = rep(0, N)
        allocation[index] = 1
        comparison = allocation==gold
        specificity[i] = sum(comparison[gold==0])/n0
        sensitivity[i] = sum(comparison[gold==1])/n1
    }
    sensitivity = c(1, sensitivity, 0)
    specificity = c(0, specificity, 1)
    cutoff = c(min(cutoff), cutoff)
    return(list(sensitivity=sensitivity, invspecificity=1-specificity))
}
