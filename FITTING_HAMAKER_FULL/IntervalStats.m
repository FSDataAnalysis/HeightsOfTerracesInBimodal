function [xx, yy, yy_plus_ser, yy_minus_ser, yy_plus_sei, yy_minus_sei]= ...
            IntervalStats (x, y)

    meanx=mean(x);
    meany=mean(y);
   
    S_xy=sum((x-meanx).*(y-meany));  
    S_xx=sum((x-meanx).^2);
    
    beta1=S_xy/S_xx;
    beta0=meany-beta1*meanx;
    
    xx=min(x):0.01:max(x);
    yy=beta0+beta1*xx;
    
    n=length(x);  
    
    residual= y-(beta0+beta1.*x);
    SSE=sum(residual.^2);
    
    sigma=sqrt(SSE/(n-2));
  
    student_95=tinv(0.975,n-2);
    
    SE_r=sigma*sqrt(1/n +((xx-meanx).^2)./S_xx);
    SE_i=sigma*sqrt(1+1/n +((xx-meanx).^2)./S_xx);
    
    yy_plus_ser=yy+student_95*SE_r;
    yy_minus_ser=yy-student_95*SE_r;
    
    yy_plus_sei=yy+student_95*SE_i;
    yy_minus_sei=yy-student_95*SE_i;

end