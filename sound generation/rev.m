function reverb=rev(source,coefficient, delay);

liquidsound = source;
d = delay * 500;

for i = 1:3,
    b=[coefficient zeros(1,round(d/i)) 1];
    a=[1 zeros(1,round(d/i)) coefficient];
    liquidsound = filter(b, a, liquidsound);
end

reverb = liquidsound;