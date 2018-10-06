% Plot the Chebyshev variety and the corresponding LC node points

clear all;
close all;

% Parameter of the Chebyshev variety

m = [4,4];          %frequency parameters of the variety
kappa = [0,1];      %phase shift parameters of the variety

range = [-1,1,-1,1];  %range for plotting

%compute gcd of m(1) and m(2) as well as the type of the variety
g = gcd(m(1),m(2));
e = mod(kappa(1)+kappa(2),2);

% Compute the single Lissajous curves of the variety
% and normalize to range

t = 0:0.001:2*pi;

x = zeros(g,length(t));
y = zeros(g,length(t));

for i = 1:g
  x(i,:) = cos(m(2)*t/g);
  y(i,:) = cos(m(1)*t/g+(2*(i-1)+e)*pi/m(2));
  [x(i,:),y(i,:)] = norm_range(x(i,:),y(i,:),[-1 1 -1 1],range);
end

% Compute the coordinates of the node points:
[xLC, yLC, wLC] = LC2Dpts(m,kappa,range);

% Compute the coordinates of the spectral index set

R = LC2Dmask(m,kappa,0);
NoLC = nnz(R);
gamma = zeros(NoLC,2);
i1 = 1; 

for i = 0:m(1)
    for j = 0:m(2)
            if (R(i+1,j+1) > 0)
                gamma(i1,:) = [i,j];
                i1 = i1+1;
             end
    end
end

% Plot Chebyshev variety and LC points

figure(1),clf,

for i = 1:g
  plot(x(i,:),y(i,:),'Color' ,[183,207,246]/255,'LineWidth',2);
  hold on
end

plot(xLC,yLC,'o','LineWidth',2,'MarkerSize',10,...
             'MarkerEdgeColor','k','MarkerFaceColor',[65,105,225]/255);
         
axis([range(1)-0.1 range(2)+0.1 range(3)-0.1 range(4)+0.1]);
         
set(gca,'FontSize',20);

title(['\fontsize{16} LC^{(m)}_{\kappa} points and Chebyshev variety C^{(m)}_{\kappa}'])

hold off

% Plot spectral index set

figure(2),clf,

line([0,0],[0,m(2)],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on
line([m(1),0],[0,0],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on
line([m(1),0],[0,m(2)],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on
line([m(1)/2, m(1)/2 ],[0,m(2)/2],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on
line([m(1)/2,0],[m(2)/2, m(2)/2],'LineStyle','--','LineWidth',2,'Color',[.85 .85 .85]);
hold on

plot(gamma(:,1),gamma(:,2),'o','LineWidth',2,'MarkerSize',10,...
             'MarkerEdgeColor','k','MarkerFaceColor',[181,22,33]/255);
hold on

axis([-0.5,m(1)+0.5,-0.5,m(2)+0.5]);
  
set(gca,'FontSize',20);

title(['\fontsize{16} Spectral index set \Gamma^{(m)}_{\kappa}'])

hold off
