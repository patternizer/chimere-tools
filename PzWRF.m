function [z,P]=PzWRF(P0,P1,P2,n)

%--------------------------------------------------------------------------
% Dr. Michael Taylor: 
% Laboratory of Atmospheric Physics, Aristotle University of Thessaloniki
% http://users.auth.gr/mtaylor/
% email(1): mtaylor@auth.gr
% email(2): patternizer@gmail.com
% Version 1.0: 01/06/2016
%--------------------------------------------------------------------------

    nWRF = n;
    p0  = P0; % station   (hPa)
    p1  = P1; % 1st level (hPa)
    p2  = P2; % nth level (hPa)
    x   = linspace(p1,p2,nWRF);
    P   = x;
%     P   = 10.^x;
%     P   = logspace(log10(p1),log10(p2),n);
    zf  = (1 - ((P./p0).^0.190284)) * 145366.45; % feet
    z   = 0.3048*zf;                             % metres

end