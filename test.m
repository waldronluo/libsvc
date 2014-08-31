M = randi (20,20,2);

C = 1;

q = 1 / (max(M) * min(M)');

M

kkkk = [];
for i = 1:100
    kkkk = [kkkk;libsvc(M, 1, q)]
end

kkkk

min (kkkk)

max (kkkk)
