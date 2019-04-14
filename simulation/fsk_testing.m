%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fork and adaptation of https://se.mathworks.com/matlabcentral/fileexchange/44821-matlab-code-for-fsk-modulation-and-demodulation
%Any and all alterations or additions to the original code was made by the contributors of this repository.
%THIS, and only THIS document is free to use, modify and share, as long as it is conformant to the GPL License
%meaning you are obliged to share modifications if should you make any.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%MODULAÇÃO, DEMODULAÇÃO COM INTRODUÇÃO DE NOISE E AVALIAÇÃO DE ERRO DE BIT

data = [1 0 1 0 1 1 1 0 0 1]; %defina os bits a serem modulados na onda
nro_bits = length(data);

%DEFINIR SINAL CARRIER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%frequência e período da onda carrier
frequencia_carrier = 1000; 
periodo_carrier = 1/frequencia_carrier;

%frequência e período que definem a sampling rate(baseado na f e t da carrier)
f_sampling = frequencia_carrier * 100;
periodo_sampling = 1/f_sampling;

%tempo de retardamento da onda gerada.
%quanto maior esse valor, maior o tamanho de samplings t, dito que o período da carrier esteja definido.
holdup_time = 10;
proportional_holdup_time = holdup_time*nro_bits;
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
tempo_sampling = 0:periodo_sampling:(periodo_carrier*holdup_time);
pulso_quadrado = [];
	for i=1:nro_bits
		for j=1:length((tempo_sampling - 1))
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

%definição das frequencias moduladas
carrier_alta = sin(2*pi*tempo_sampling*frequencia_alta); %bit alto
carrier_baixa = sin(2*pi*tempo_sampling*frequencia_baixa); %bit baixo

sinal_modulado = [];

%faça um vetor-função que tenha como domínio divisões do período de sampling e vá até um período qualquer da onda carrier. 
%carregue esse vetor-função os valores apropriados da imagem dependendo do bit num vetor binário pre-existente

%esse vetor terá, efetivamente, a mesma range de valores que definem o duty-cycle do vetor binário
%mas uma sampling rate dependente do domínio da função de carrier
%ou seja: carregará duas funções baseadas no domínio e frequencia da função de carry
%dependendo do valor de um vetor-binário.
for i=1:nro_bits
     if(data(i)==1)
         sinal_modulado = [sinal_modulado carrier_alta];
     else
         sinal_modulado = [sinal_modulado carrier_baixa];
     end
 end

%plota o sinal já modulado
subplot(5, 1, 3);
plot(sinal_modulado, 'm');
xlabel('Onda quadrada modulada no sinal do carrier');
ylabel('Amplitude');

%adiciona white gaussian noise no sinal (a fins de imitar a vida real e tudo mais)

ruido = 10;
onda_transmitida = awgn(sinal_modulado, ruido); %adiciona ruido no sinal
subplot(5, 1, 4);
plot(onda_transmitida, 'r');
xlabel('Sinal recebido');
ylabel('Amplitude');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PROCESSO DE DEMODULAÇÃO - PHASE LOCKED LOOP

negative=0;
positive=0;

%é ok deixar esse sampleValue igual ao número de bits pra valores de vetor <20
sampleValue = nro_bits;

dif_sinal=0;
nro_zeros=0;
amostra_de_zeros=[];
k=1;
for i=1:nro_bits
    for j=1:length(tempo_sampling)
        if(dif_sinal>sampleValue)
            if(onda_transmitida(1,k)>0)
                positive=1;    
            end
            if(onda_transmitida(1,k)<0)
                negative=1;
            end
        end
        k++;
        dif_sinal=dif_sinal+1;
        if(positive==1 && negative==1)
            nro_zeros++;
            positive=0;
            dif_sinal=0;
            negative=0;
        end
    end
    amostra_de_zeros=[amostra_de_zeros nro_zeros];
    nro_zeros=0;     
end

%normalize os vetores dividindo-os pela MALVADA
amostra_de_zeros=amostra_de_zeros/mean(amostra_de_zeros);

filtData=[];
for i=1:length(amostra_de_zeros)
 if(amostra_de_zeros(i)>=1)
     filtData=[filtData 1];
 else
     filtData=[filtData 0];
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);
subplot(3, 1, 1);
stem(data, 'Linewidth', 3);
xlabel('Samples(Message signal)');
ylabel('Amplitude');

subplot(3, 1, 2);
stem(filtData,'g','Linewidth',3);
xlabel('Samples(Recieved signal)');
ylabel('Amplitude');

subplot(3, 1, 3);
stem(abs(data-filtData),'r','Linewidth',2);
xlabel('Samples(Error signal)');
ylabel('Amplitude');

[BIT_ERROR_RATE NORMALIZED_BIT_ERROR_RATE]=biterr(data,filtData)
























