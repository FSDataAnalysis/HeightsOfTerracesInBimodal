function [beta0, beta1, SE_beta0, SE_beta1, p_beta0, ...
            p_beta1, t_beta0, t_beta1, beta1_minus, beta1_plus]= ...
            GetCoefficients (x, y)

    meanx=mean(x);
    meany=mean(y);
    
    S_xy=sum((x-meanx).*(y-meany));  
    S_xx=sum((x-meanx).^2);
    
    beta1=S_xy/S_xx;
    beta0=meany-beta1*meanx;
    
    n=length(x);
    residual= y-(beta0+beta1.*x);
    
    SSE=sum(residual.^2);
     
    sigma=sqrt(SSE/(n-2));
  

    SE_beta0=sigma*((1/n + (meanx^2)/S_xx)^(0.5));
  
    SE_beta1=sigma/sqrt(S_xx);
  
    t_beta0=beta0/SE_beta0;
    t_beta1=beta1/SE_beta1;
  
    p_beta0=2*(1-tcdf(abs(t_beta0),n-2));
    %%% Inference on slope %%%%%%%%%%%%%
    p_beta1=2*(1-tcdf(abs(t_beta1),n-2));
    
    %%% confidence interval slope %%%%%
    student_95=tinv(0.975,n-2);  %%% 95% confidence interval
    
    beta1_minus=beta1-student_95*sigma/sqrt(S_xx);
    beta1_plus=beta1+student_95*sigma/sqrt(S_xx);
    
    
end