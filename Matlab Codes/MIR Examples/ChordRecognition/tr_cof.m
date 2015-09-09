function final_tr = tr_cof()

final_tr = zeros(24);

for i = 0:23
    final_tr(i+1,i+1) = (12 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+16, 24)+1) = (11 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+21, 24)+1) = (11 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+7 , 24)+1) = (10 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+5 , 24)+1) = (10 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+23, 24)+1) = (9 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+14, 24)+1) = (9 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+2,  24)+1) = (8 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+10, 24)+1) = (8 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+19, 24)+1) = (7 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+18, 24)+1) = (7 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+9,  24)+1) = (6 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+3,  24)+1) = (6 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+12, 24)+1) = (5 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+13, 24)+1) = (5 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+4,  24)+1) = (4 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+8,  24)+1) = (4 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+17, 24)+1) = (3 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+20, 24)+1) = (3 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+11, 24)+1) = (2 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+1,  24)+1) = (2 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+22, 24)+1) = (1 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+15, 24)+1) = (1 + realmin)/(144+24*realmin);
    final_tr(i+1,mod(i+6,  24)+1) = (0 + realmin)/(144+24*realmin);
end
for i = 1:length(final_tr(:,1))
    final_tr(i,:) = final_tr(i,:)/sum(final_tr(i,:));
end
end