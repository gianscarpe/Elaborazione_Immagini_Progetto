function exps1 = ExpandString(s1)
    m = length(s1);
    c = 1;
    exps1 = char([]);
    for i = 1 : m
            j = s1(i);
            if (isstrprop(j, 'digit'))
               j = str2num(j);
               exps1(c : c + j - 1) = 'x';
               c = c + j;
            else
                exps1(c) = j;
                c = c + 1;
            end

    end
    
end
