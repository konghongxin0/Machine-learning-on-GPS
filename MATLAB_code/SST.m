SSTact=0;
SSTsel=0;
for n=3:1:7
for i=1:1:50
	curselx=(selx(n)-selx(n-1))/50*i+selx(n-1);
	cursely=(sely(n)-sely(n-1))/50*i+sely(n-1);
	curactualx=(actualx(n)-actualx(n-1))/50*i+actualx(n-1);
	curactualy=(actualy(n)-actualy(n-1))/50*i+actualy(n-1);
	curaveragex=(averagex(n)-averagex(n-1))/50*i+averagex(n-1);
	curaveragey=(averagey(n)-averagey(n-1))/50*i+averagey(n-1);
    deta_lati=pi*(curaveragex-curactualx)/180;
    deta_longti=pi*(curaveragey-curactualy)/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*curaveragex/180)*cos(pi*curactualx/180)*(sin(deta_longti/2))^2);
    dis=2*6372704*asin(hav);  
    SSTact=SSTact+dis;
	deta_lati=pi*(curselx-curactualx)/180;
    deta_longti=pi*(cursely-curactualy)/180;
    hav=sqrt((sin(deta_lati/2))^2+cos(pi*curselx/180)*cos(pi*curactualx/180)*(sin(deta_longti/2))^2);
    dis=2*6372704*asin(hav);  
    SSTsel=SSTsel+dis;
end
end
fprintf('average method SST£º%f\n' ,SSTact);
fprintf('classfication method SST£º%f\n' ,SSTsel);