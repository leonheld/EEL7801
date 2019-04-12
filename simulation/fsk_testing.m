%Modulação, demodulação e avaliação de bit error entre os resultados

data = [1 0 0 0 0 0 1]; %defina os bits a serem modulados na onda

%DEFINIR SINAL CARRIER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%frequência e período da onda carrier
frequencia_carrier = 1000; 
periodo_carrier = 1/frequencia_carrier;

%frequência e período que definem a sampling rate(baseado na f e t da carrier)
f_sampling = frequencia_carrier * 50;
periodo_sampling = 1/f_sampling;

%tempo de retardamento da onda gerada.
%quanto maior esse valor, maior o tamanho de samplings t, dito que o período da carrier esteja definido.
holdup_time = 20;
proportional_holdup_time = holdup_time*length(data);
%definição do vetor de tempo de sampling
t = 0:periodo_sampling:(proportional_holdup_time*periodo_carrier); 
   %de zero até o tamanho do vetor que deseja carregar vezes o período da onda de carregamento 

onda_carrier = sin(2*pi*t*frequencia_carrier); %carrier wave: um seno com frequência delimitada pelos valores de t vezes valor de N(que depende do numero de bits)
figure;
subplot(3,1,1);
plot(onda_carrier);
xlabel('Carrier sinal');
ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CONVERTER OS DATA BITS EM ONDA QUADRADA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
periodo_pulso_quadrado = 0:periodo_sampling:(holdup_time*periodo_carrier);
pulso_quadrado = [];
	for i=1:length(data)
		for j=1:length((periodo_pulso_quadrado) - 1)
			pulso_quadrado = [pulso_quadrado data(i)];
		end
	end
pulso_quadrado(1, size(pulso_quadrado)+1) = pulso_quadrado(1, size(pulso_quadrado));

subplot(3,1,2)
plot(pulso_quadrado,'g','Linewidth',2)
xlabel('Pulso quadrado de Mensagens');
ylabel('Amplitude');