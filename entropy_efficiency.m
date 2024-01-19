function [entro, efficiency] = entropy_efficiency(prob_vector, avg_length)
    
    if ~isempty(find(prob_vector<0, 1))
        error('A probability vector cannot have negative components')
    end
    %%Check sum of vectors, must add up to 1
    if abs(sum(prob_vector)-1)>10e-10
        error ('A probability vector must have a sum of 1')
    end
    
    % Calculate Entropy
    entro = sum(-prob_vector.*log2(prob_vector));
    
    %Calculate Efficiency
    efficiency = entro/avg_length;
    
end

