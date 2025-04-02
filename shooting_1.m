function [eta1,f] = shooting_1
F = [0,0,0];
[eta1,f] = ode45(@(eta,f) [f(2); f(3); -0.5*f(1)*f(3)],[0 10],F);
while f(end,2)<0.9999 || f(end,2)>1.0001
    [eta1,f] = ode45(@(eta,f) [f(2); f(3); -0.5*f(1)*f(3)],[0 10],F);
    if f(end,2)<1
        F(3)=F(3)+0.0001;
    else
        F(3)=F(3)-0.0001;
    end    
end
figure(1); hold on;
plot(eta1,f(:,1),'r-','Linewidth',1.5)
plot(eta1,f(:,2),'g-','Linewidth',1.5)
plot(eta1,f(:,3),'k-','Linewidth',1.5)
xlabel('\eta');
ylabel('\it{f, f^{ \prime}, f^{ \prime\prime}}');
xlim([0 10]);
ylim([0 2]);
legend('\it{f}','\it{f}^{ \prime}','\it{f^{ \prime\prime}}');
saveas(gcf, 'Similarity_Solution_1.png');