function uprofile(eta1,f,u_inf,nu)
    F1 = @(t) interp1(eta1, f(:,2)-0.99, t, 'linear');
    n=fsolve(F1,0);
    x=linspace(0,100000,100);
    delta=n*sqrt(nu/u_inf).*sqrt(x);
    F2 = @(t) interp1(eta1, f(:,2), t, 'linear');
    figure(3); hold on;
    for i=10000:30000:100000
        l=linspace(0,delta(100),100);
        q=i*ones(size(l));
        u=u_inf*F2(l*sqrt(u_inf/(nu*i)));
        plot3(q,u,l,'k-','Linewidth',1.5)
        plot3(q,q-i,l,'k-','Linewidth',1.5)
    end
    plot3(x,u_inf*ones(size(x)),delta,'r-','Linewidth',2)
    grid on;
    xlabel('x');
    ylabel('u');
    zlabel('y');
    xlim([0 100000]);
    ylim([0 1.5*u_inf]);
    zlim([0 1.1*delta(100)]);
    xticks(10000:30000:100000);
    view(3);
    saveas(gcf, 'boundary_layer_plot_1.png');