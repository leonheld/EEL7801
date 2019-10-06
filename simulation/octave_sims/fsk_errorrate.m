%% fsk_errorrate: function description
function [outputs] = fsk_errorrate(number_iterations)

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
    tempo_sampling = 0:periodo_sampling:(periodo_carrier*holdup_time);

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

    error_vector = [];
    noise = linspace(0, 50, number_iterations);

    for i = 1:number_iterations
        error_vector = [error_vector fsk_demod(sinal_modulado, noise(i))];
    end

    mean(error_vector)
    plot(noise, error_vector)
end