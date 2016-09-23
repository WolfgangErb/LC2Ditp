% Plot Lissajous curve and the corresponding node points

clear all;
close all;

% Parameter of the Lissajous curve

n = [4,5];          %frequencies
e = 2;              %e = 1: degenerate case, e=2: non-degenerate case

range = [-1,1,-1,1];  %range of the Lissajous curve

%normalize n in case n(1) and n(2) are not relatively prime

n = n/gcd(n(1),n(2));

% Computation of the Lissajous curve

t = 0:0.001:2*pi;

x = cos(n(2)*t);
y = cos(n(1)*t+(e-1)*pi/n(2)/2);

[x,y] = norm_range(x,y,range);

% Computation of node points (equidistant points along trajectory)

N = 2*e*n(1)*n(2);

xLS = zeros(N,1);
yLS = zeros(N,1);

NoLS = ((e*n(1)+1)*(e*n(2)+1)-(e-1))/2;
Nint = ((e*n(1)-1)*(e*n(2)-1)-(e-1))/2;
Nout = e*n(1)+e*n(2);

for k = 1:N
    xLS(k) = cos(2*pi*k*n(2)/N);
    yLS(k) = cos(2*pi*k*n(1)/N+(e-1)*pi/2/n(2));
end

[ xLS,yLS ] = norm_range( xLS,yLS, range);

%For an alternative computation of the node points use explicit formula:
%[xLS, yLS, wLS] = LS2Dpts(n,e,range);

if (e==1)
    fprintf('Degenerate Lissajous curve with frequencies n = (%d,%d) \n',n(1),n(2));
elseif (e==2)
    fprintf('Non-degenerate Lissajous curve with frequencies n = (%d,%d) \n',n(1),n(2));
end
fprintf('Complete number of LS points in [-1,1]^2  : %10d \n',NoLS);
fprintf('Points of LS in the interior of [-1,1]^2  : %10d \n',Nint);
fprintf('Points of LS on the boundary of [-1,1]^2  : %10d \n',Nout);

% Plot curve and points

figure 

plot(x,y,'Color' ,[0.7 0.7 0.7],'LineWidth',2);

hold on

plot(xLS,yLS,'o','LineWidth',2,'MarkerSize',6,...
             'MarkerEdgeColor','k','MarkerFaceColor',[0.5,0.5,0.5]);
         
set(gca,'FontSize',15);

xlabel('x'); ylabel('y'); 
title('Lissajous curve $\gamma^{(\underline{\mathbf{ n}})}_e$ and interpolation nodes $\mathbf{LS}^{(e \underline{\mathbf{n}})}$', ...
'interpreter','latex','fontsize',16)

hold off