%plot as time  series (minimum easy to see, however no convergence)
load count.dat
count1 = timeseries(mat(:,5),1:9);
count1.Name = 'CVaR Value';
count1.TimeInfo.Units = 'Iterations';
plot(count1,':b')
grid on
