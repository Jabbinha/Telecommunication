function AMDSB()
%DADOS DE ENTRADA
fo=154000;
fm=fo/100;
fs=100*fo;
wo=2*pi*fo;
wm=2*pi*fm;
t=0:1/fs:4/fm;
xo=cos(wo*t);
xm=cos(wm*t);

%FIGURA 1 = PORTADORA E MODULADORA
figure(1)
subplot(2,1,1),plot(t,xo);
title('SINAL DA PORTADORA DE 154 khz');
xlabel('tempo (seg)');
ylabel('amplitude');
subplot(2,1,2),plot(t,xm);
title('SINAL DA MENSAGEM DE 15.4 khz');
xlabel('tempo (seg)');
ylabel('amplitude');

%FIGURA 2 = MODULACAO AMDSB-SC
%DOMINIO DO TEMPO
z1= xm.*xo;
figure(2)
subplot(2,1,1),plot(t,z1);
title('MODULAÇAO DSB-SC NO DOMINIO DO TEMPO');
xlabel('tempo (seg)');
ylabel('amplitude');
%DOMINIO DA FREQ
l1=length(z1);
f=linspace(-fs/2,fs/2,l1);
Z1=fftshift(fft(z1,l1)/l1);
subplot(2,1,2),plot(f,abs(Z1));
title('MODULAÇAO DSB-SC NO DOMINIO DA FREQ');
xlabel('frequencia(hz)');
ylabel('amplitude');
axis([-250000 250000 0 0.3]);

%FIGURA 3 = DEMODULAçAO AMDSB-SC ANTES
%DOMINIO DA FREQ ANTES DE DEMODULAR
s1=z1.*xo;
S1=fftshift(fft(s1,length(s1))/length(s1));
figure(3)
plot(f,abs(S1));
title('DEMODULAÇAO DSB-SC NO DOMINIO DA FREQ ANTES DOS FILTROS PB');
xlabel('frequencia(hz)');
ylabel('amplitude');
axis([-250000 250000 0 0.3]);
hold on
Hlp=1./sqrt(1+(f./fo).^(2*100));
plot(f,Hlp,'r');
title(' RESPOSTA EM FREQUENCIA');
xlabel('frequencia(hz)');
ylabel('amplitude');
axis([-250000 250000 0 2]);
E1=Hlp.*S1;
%FIGURA 3 = DEMODULAçAO AMDSB-SC DEPOIS
%DOMINIO DA FREQ DEPOIS DE DEMODULAR
figure(4)
subplot(2,1,1),plot(f,E1);
title('DEMODULAÇAO DSB-SC NO DOMINIO DA FREQ DEPOIS DOS FILTROS PB');
xlabel('frequencia(hz)');
ylabel('amplitude');
axis([-200000 200000 0 0.3]);
%DOMINIO DO TEMPO DEPOIS DE DEMODULAR
e1=ifft(ifftshift(E1))*length(E1);
subplot(2,1,2),plot(t,(1/0.5)*e1);
title('DEMODULAÇAO DSB-SC NO DOMINIO DO TEMPO DEPOIS DOS FILTROS PB');
xlabel('tempo(seg)');
ylabel('amplitude');
end