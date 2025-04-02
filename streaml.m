function [u,v]=streaml(eta1,f,nu,u_inf)
    [x1, y1] = meshgrid(0:100,0:100);
    y_interp = @(t) interp1(eta1, f(:, 2), t, 'linear', 'extrap');
    z_interp = @(t) interp1(eta1, f(:, 1), t, 'linear', 'extrap');
    u = zeros(size(x1));
    v = zeros(size(y1));
    for i = 1:numel(x1)
        if x1(i) > 0
            y_val = y1(i) * sqrt(u_inf  / x1(i)* nu);
            u(i) = u_inf * y_interp(y_val);
            v(i) = 0.5 * sqrt(u_inf*nu / x1(i)) * (y_val * y_interp(y_val) - z_interp(y_val))*10^5;
        else
            u(i) = 0;
            v(i) = 0;
        end
    end
    figure(6);
    streamslice(x1, y1, u, v);
    % axis tight;
    title('Streamlines of the Flow Field');
    xlabel('x');
    ylabel('y*10^-5');
    saveas(gcf, 'Streamlines.png');
