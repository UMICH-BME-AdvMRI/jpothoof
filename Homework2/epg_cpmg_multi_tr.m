% function [s,phasediag,P] = epg_cpmg(flipangle,etl,T1,T2,esp)
%
%	EPG Simulation of CPMG sequence.  First flip angle
%	is 90 about y axis, and others by default are about
%	x-axis (make flipangle complex to change that).
%
%	flipangle = refocusing flip angle or list (radians)
%	etl = echo train length, if single flipangle is to be repeated.
%	T1,T2,esp = relaxation times and echo spacing (arb. units).
%
%	Note that if refoc flip angle is constant, less than pi, and etl > 1 the
%	first refocusing flip angle is the average of 90 and the desired
%	refocusing flip angle, as proposed by Hennig.
%
%	All states are kept, for demo purposes, though this 
%	is not really necessary.

function [s,phasediag,P] = epg_cpmg_multi_tr(flipangle,etl,T1,T2,esp,TR,ntrs,M0,dispflag)
%        [s,phasediag,P] = epg_cpmg_multi_tr(flipangle,etl,t1val,t2val,esp,TR,numTRs,m0val,0);
    
if nargin<6, TR=[]; end
if nargin<7 || isempty(TR), ntrs=1; end
if nargin<8, M0=1; end
if nargin<9, dispflag=0; end

% -- Default parameters:  ETL = length(flipangle)
if (length(etl)==0), etl = length(flipangle); end

if (length(flipangle)==1) && (etl > 1) && (abs(flipangle)<pi)	
  % -- 1st flip reduced trick (Hennig)
  flipangle(2)=flipangle(1);
  flipangle(1)=(pi*exp(1i*angle(flipangle(2)))+flipangle(2))/2;
end
if (etl > length(flipangle)), flipangle(end+1:etl) = flipangle(end); end

P = zeros(3,2*etl);		% Allocate all known states, 2 per echo.
P(3,1)=1*M0;			% Initial condition/equilibrium.

Pstore = zeros(4*etl,etl);	% Store F,F* states, with 2 gradients per echo
Zstore = zeros(2*etl,etl);	% Store Z states, with 2 gradients per echo

for thistr=1:ntrs
    % -- 90 excitation
    
    P = epg_rf(P,pi/2,pi/2);	% Do 90 tip.
    s = zeros(1,etl);		% Allocate signal vector to store.
    
    for ech=1:etl
      P = epg_grelax(P,T1,T2,esp/2,1,0,1,1);   % -- Left crusher
      P = epg_rf(P,abs(flipangle(ech)),angle(flipangle(ech)));   % -- Refoc. RF
      P = epg_grelax(P,T1,T2,esp/2,1,0,1,1);   % -- Right crusher
    
      s(ech) = P(1,1);  	% Signal is F0 state.
      Pstore(2*etl:4*etl-1,ech) = P(2,:).';	% Put in negative states
      Pstore(1:2*etl,ech) = flipud(P(1,:).');  % Put in positive, overwrite center.
      Zstore(:,ech) = P(3,:).';
    
    end

    if ntrs>1 && ~isempty(TR)
        % Simulate relaxation from end of echo train to start of next
        t_to_next_tr = TR - (esp*etl);
        %   epg_grelax(FpFmZ,T1,T2,T,kg,D,Gon,noadd)
        P = epg_grelax(P,T1,T2,t_to_next_tr,0,0,0,1);
    end

end

% if ntrs>1 && ~isempty(TR)
%     s(ech) = P(1,1);  	% Signal is F0 state.
%     Pstore(2*etl:4*etl-1,ech) = P(2,:).';	% Put in negative states
%     Pstore(1:2*etl,ech) = flipud(P(1,:).');  % Put in positive, overwrite center.
%     Zstore(:,ech) = P(3,:).';
% end

plotstate = cat(1,Pstore,Zstore);
if dispflag
dispim(plotstate);
xlabel('Echo'); ylabel('F(top) and Z(bottom) States');
end
phasediag = plotstate;	
