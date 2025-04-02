function Heatl(eta1,eta2,tetha,f,ro,cp,u_inf,nu,T0,T_inf,pr)
    [x1, y1] = meshgrid(0:1:100, 0:1:100);
    z1_interp = @(x) interp1(eta2, tetha(:, 1), x, 'linear', 'extrap');
    z2_interp = @(x) interp1(eta2, tetha(:, 2), x, 'linear', 'extrap');
    z3_interp = @(t) interp1(eta1, f(:, 2), t, 'linear', 'extrap');
    z4_interp = @(t) interp1(eta1, f(:, 1), t, 'linear', 'extrap');
    H1 = zeros(size(x1));
    H2 = zeros(size(y1));
    if T_inf>T0
    C=ro*cp*u_inf*(T_inf-T0)*sqrt(nu/u_inf);
    for i = 1:numel(x1)
        if x1(i) > 0
            sqrt_term = sqrt(u_inf  / x1(i)* nu);
            y_val =y1(i) * sqrt_term;
            H1(i)=C*z3_interp(y_val)*z1_interp(y_val)*10^5;
            H2(i)=C*(0.5*sqrt(1/x1(i))*(y_val*z3_interp(y_val)-z4_interp(y_val))*z1_interp(y_val)-(1/pr)*(sqrt(1/x1(i))*z2_interp(y_val)));
        else
            H1(i) = 0;
            H2(i) = 0;
        end
    end
    else
    C=ro*cp*u_inf*(T0-T_inf)*sqrt(nu/u_inf);
    for i = 1:numel(x1)
        if x1(i) > 0
            sqrt_term = sqrt(u_inf  / x1(i)* nu);
            y_val =y1(i) * sqrt_term;
            H1(i)=C*z3_interp(y_val)*(1-z1_interp(y_val));
            H2(i)=C*(0.5*sqrt(1/x1(i))*(y_val*z3_interp(y_val)-z4_interp(y_val))*(1-z1_interp(y_val))+(1/pr)*(sqrt(1/x1(i))*z2_interp(y_val)));
        else
            H1(i) = 0;
            H2(i) = 0;
        end
    end
    end    
    figure(7);
    streamslice(x1, y1,H1,H2 );
    axis tight;
    title('heatline of the Flow Field');
    if T_inf>T0
        xlabel('x*10^5');
    else
        xlabel('x');
    end
    ylabel('y');
    saveas(gcf, 'Heatlines.png');    