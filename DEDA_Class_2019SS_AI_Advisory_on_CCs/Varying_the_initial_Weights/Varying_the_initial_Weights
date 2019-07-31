%import the predictions made by the neural network
output = predictions1{:,:}
r= output
%define a confidence level  for the  calculation of the CVaR
q = 0.95
%save the dimensions of the output table in the variables i and j
[i,j] = size(r)

%define the objective function
n = 1:j
Rfunction = @(w) w(j+1) + (1/j)*(1/(1-q))*sum(max(-w(n)*r(:,n)'-w(j+1),0))

%define the constraints
%define  matrix  A
%A = zeros(9,5)
%A(2:5,1:4) = -eye(4)
%A(6:9,1:4) = eye(4)
%A(1,1:4)= mean(output(2:25,1:4))

%define matrix B
%b = zeros(9,1)
%b(2:5,1) = 0  %-1 and 1; -1 and no UB; no LB & 1; no LB and no UB
%b(6:9,1) = 0

%define Aeq and beq
Aeq = [ones(1,j) 0]
beq = [1]

%create an empty matrix to collect the results from all iterations
mat = zeros(9,9)
%create an array with the headers of the matrix: w1-w4 => optimal weights;
%CVaR => optimized/minimized CVaR; wi_1-wi_4 => initial weights;
header = {'w1', 'w2', 'w3', 'w4', 'CVaR', 'wi_1', 'wi_2', 'wi_3' ,'wi_4'}

%put all possible combinations  of initial weights from Python into a table
x = combisS1
%transform the table into a 2D array
y = table2array(x)


%run a loop through all possible combinations of possible weights to see
%which one leads to a minimal CVaR
for f = 1:9
w0 = y(f,:)
%firstly calculate the VaR under the confidence level stated above
VaR = quantile(r*w0',q)

%pack the initial weights and the VaR together as initial points for the
%caclculation of the optimal weights and the corresponding CVaR
w0 = [w0 VaR]


%minimize the objective function under the constraints defined above using fmincon
[w,CVaR] = fmincon(Rfunction, w0,[],[], Aeq, beq)
mat(f,1:5) =[w(1:4), CVaR]
mat(f,6:9) = w0(1:4)

end

%pack the matrix mat(already  filled with results) into a dataset with the
%headers defined above
ds = dataset({mat,header{:}})
