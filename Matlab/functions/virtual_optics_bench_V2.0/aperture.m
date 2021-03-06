function u1=aperture(lam, npoints,range,u0,radius,zdist)
%u1=aperture(lambda, u0,radius,zdist)
%u0: original beam
%radius: radius of aperture
%zdist: distance to propagate after aperture



%set up code
lambda=lam*1e-6; %mms;
k=2*pi/lambda; 


step=range/npoints;
distance=zdist;

scale=-range/2:step:range/2-step;
ftscale=(npoints/range^2)*scale;
xvec=scale;
yvec=xvec;



[fx,fy]=meshgrid(ftscale,ftscale);



[xi,yj]=meshgrid(scale,scale);


r=sqrt(xi.^2+yj.^2);
ap=1+xi.*0+yj.*0;


ind=find(r > radius);
ap(ind)=0;

mt1=u0.*ap;


dt=fftshift(fft2(mt1));

ff=h2(fx,fy,distance,lambda);

ft=ff.*dt;

u1=ifft2(fftshift(ft));

% colormap('gray')
% result=abs(u1).^2;
% %imagesc(scale,scale,mod(angle(mt),2*pi),[0 2*pi])
% imagesc(scale,scale,result);
% axis([min(scale)/2.4 max(scale)/2.4 min(scale)/2.4 max(scale)/2.4]);
% 
% string=['d = ' num2str(zdist, '%6.0f') ];
% %string=['g = ' num2str(g,'%1.2f')];
% %text(-1.1,-1.1,string,'Color',[1,1,1]);
% axis('square');

end
