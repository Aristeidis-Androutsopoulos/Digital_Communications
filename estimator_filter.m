function m_cap = estimator_filter(y_memory, a)
    %estimator_filter: Summary of this function goes here
    %   Detailed explanation goes here
    
    m_cap = sum(a*y_memory);
end