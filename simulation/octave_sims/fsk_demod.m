%% fsk_demod: function description
function [NORMALIZED_BIT_ERROR_RATE] = fsk_demod(sinal_modulado, ruido)

    onda_transmitida = awgn(sinal_modulado, ruido); %adiciona ruido no sinal

    data = [1 0 1 0 1 1 1 0 0 1]; %apenas necessario pra computar a taxa de erro
    nro_bits = length(data);

    holdup_time = 10;

    frequencia_carrier = 1000; 
    periodo_carrier = 1/frequencia_carrier;

    f_sampling = frequencia_carrier * 100;
    periodo_sampling = 1/f_sampling;

    holdup_time = 10;
    
    tempo_sampling = 0:periodo_sampling:(periodo_carrier*holdup_time);

    negative=0;
    positive=0;

    %é ok deixar esse sampleValue igual ao número de bits pra valores de vetor <20
    sampleValue = nro_bits;
    dif_sinal=0;
    nro_zeros=0;
    amostra_de_zeros=[];
    k=1;
    for i=1:10
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

    [BIT_ERROR_RATE NORMALIZED_BIT_ERROR_RATE]=biterr(data,filtData);
end
