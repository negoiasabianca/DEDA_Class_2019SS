%sort CVaR descending and plot a  simple graph, where
%minimum easily seen and one can see a convergence
mat1 = array2table(mat)
chr = [{'one', 'two', 'three', 'four', 'five','six','seven','eight','nine'}]
%str = ["one", "two", "three", "four", "five","six","seven","eight","nine"]
trans = array2table(transpose(chr))
mat1 (:,10) = trans
sorted = sortrows(mat1,-5)
y = table2array(sorted(:,5))
x = table2array(sorted(:,10))
plot(y)
set(gca,'xticklabel',x.')
title('CVaR-Convergence')
xlabel('Iterations')
ylabel('CVaR-Value')
