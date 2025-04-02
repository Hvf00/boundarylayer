function utplot(eta1,f,eta2,tetha)
    figure(8);
    plot(f(:,2),eta1,'k-','Linewidth',1.5)
    ylim([0 10]);
    xlabel('u/U_∞');
    ylabel('\eta');
    title('η vs.u/U_∞');
    saveas(gcf, 'boundary_layer_plot_2.png');
    figure(9);
    plot(tetha(:,1),eta2,'b','Linewidth',1.5)
    xlim([0 1]);
    xlabel('\theta');
    ylabel('\eta');
    title('η vs. θ');
    saveas(gcf, 'boundary_layer_plot_3.png');