function V = countErrors(s1,s2) 
    e1 = expandString(s1);
    e2 = expandString(s2);
    
    V = sum((e1(1 : 71) - e2(1 : 71)) ~= 0);

end
