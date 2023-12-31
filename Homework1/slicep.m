
function [msig,m]=slicep(rf,G,t,T1,T2,pos,df)

gamma = 4258;
dT = t(2)-t(1);         % s.
rfrot = 2*pi*gamma*rf*dT; % Rotation in radians.
pos = pos(:).';		% Make 1xN.
msig = 0*pos;
m = [msig;msig;msig];

for x=1:length(pos)
    tt = sprintf('Simulating postion %d of %d',x,length(pos));
    disp(tt);
    M = [0;0;1];
    [A,B] = precess(1000*dT/2,T1,T2,df);

    for k = 1:length(rf)
	M = A*M+B;
	grot = 2*pi*gamma*(pos(x)/10)*G(k)*dT/2;
	M = rotatz(grot)*M;
    	M = rotatxyz(abs(rfrot(k)),angle(rfrot(k))) * M;	% RF Rotation.
	M = A*M+B;
	grot = 2*pi*gamma*(pos(x)/10)*G(k)*dT/2;
	M = rotatz(grot)*M;
    end;
    m(:,x) = M;
    msig(x) = M(1)+i*M(2);

end;



