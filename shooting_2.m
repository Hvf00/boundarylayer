function [eta2,tetha]=shooting_2(eta1,f,pr)
F=[0,0];
f = @(eta2) interp1(eta1, f(:,1), eta2, 'linear');
[eta2,tetha] = ode45(@(eta2,tetha) [tetha(2); -0.5*pr*f(eta2)*tetha(2)],[0 10],F);
while tetha(end,1)<0.999 || tetha(end,1)>1.001
    [eta2,tetha] = ode45(@(eta2,tetha) [tetha(2); -0.5*pr*f(eta2)*tetha(2)],[0 10],F);
    if tetha(end,1)<1
      F(2)=F(2)+0.0001;
    else
      F(2)=F(2)-0.0001;
    end    
end
figure(2); hold on;
plot(eta2,tetha(:,1),'b-','Linewidth',1.5)
plot(eta2,tetha(:,2),'y-','Linewidth',1.5)
xlabel('\eta');
ylabel('\it{\theta,\theta^{ \prime}}');
xlim([0 10]);
ylim([0 2]);
legend('\it{\theta}','\it{\theta^{ \prime}}');
saveas(gcf, 'Similarity_Solution_2.png');
