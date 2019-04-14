%Modulação, demodulação e avaliação de bit error entre os resultados

data = [1 0]; %defina os bits a serem modulados na onda

%DEFINIR SINAL CARRIER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%frequência e período da onda carrier
frequencia_carrier = 10; 
periodo_carrier = 1/frequencia_carrier;

%frequência e período que definem a sampling rate(baseado na f e t da carrier)
f_sampling = frequencia_carrier * 100;
periodo_sampling = 1/f_sampling;

%tempo de retardamento da onda gerada.
%quanto maior esse valor, maior o tamanho de samplings t, dito que o período da carrier esteja definido.
holdup_time = 20;
proportional_holdup_time = holdup_time*length(data);
%definição do vetor de tempo de sampling
t = 0:periodo_sampling:(proportional_holdup_time*periodo_carrier); 
   %de zero até o tamanho do vetor que deseja carregar vezes o período da onda de carregamento 

onda_carrier = sin(2*pi*t*frequencia_carrier); %carrier wave: um seno com frequência delimitada pelos valores de t vezes valor de N(que depende do numero de bits)
figure(1);
subplot(5,1,1);
plot(onda_carrier);
xlabel('Carrier sinal');
ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CONVERTER OS DATA BITS EM ONDA QUADRADA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
periodo_pulso_quadrado = 0:periodo_sampling:(holdup_time*periodo_carrier);
pulso_quadrado = [];
	for i=1:length(data)
		for j=1:length((periodo_pulso_quadrado - 1))
			pulso_quadrado = [pulso_quadrado data(i)];
		end
	end


subplot(5,1,2)
plot(pulso_quadrado,'k','Linewidth',2)
xlabel('Pulso quadrado de Mensagens');
ylabel('Amplitude');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PROCESSO DE MODULAÇÃO

delta_frequencia = 0.5; % o quão violenta vai ser o `amortecimento` nos carregamentos de frequencia
frequencia_alta = frequencia_carrier + (frequencia_carrier*delta_frequencia);
frequencia_baixa = frequencia_carrier - (frequencia_carrier*delta_frequencia);

%Domínio dos sinais de modulação

t = 0:periodo_sampling:(periodo_carrier*holdup_time); %domínio: intervalos de período de sampling até um proporcional do período do carrier

%definição das frequencias moduladas
carrier_alta = sin(2*pi*t*frequencia_alta); %bit alto
carrier_baixa = sin(2*pi*t*frequencia_baixa); %bit baixo

vetor_sinal_modulado = [];

%faça um vetor-função que tenha como domínio divisões do período de sampling e vá até um período qualquer da onda carrier. 
%carregue esse vetor-função os valores apropriados da imagem dependendo do bit num vetor binário pre-existente

%esse vetor terá, efetivamente, a mesma range de valores que definem o duty-cycle do vetor binário
%mas uma sampling rate dependente do domínio da função de carrier
%ou seja: carregará duas funções baseadas no domínio e frequencia da função de carry
%dependendo do valor de um vetor-binário.
for i=1:length(data)
     if(data(i)==1)
         vetor_sinal_modulado = [vetor_sinal_modulado carrier_alta];
     else
         vetor_sinal_modulado = [vetor_sinal_modulado carrier_baixa];
     end
 end


subplot(5, 1, 3);
plot(vetor_sinal_modulado, 'm');
xlabel('Onda quadrada modulada no sinal do carrier');
ylabel('Amplitude');

ruido = 10;
onda_transmitida = awgn(vetor_sinal_modulado, ruido); %coloca ruído
subplot(5, 1, 4);
plot(onda_transmitida, 'r');
xlabel('Sinal recebido');
ylabel('Amplitude');    