% this finction gives back the I_q for a particular s as mentioned in the paper with the input
% parameters as the the the reject-accept iteration s, the number of
% clusters, the arbitrary probab, the co variance matrices of all the last
% steps for all clusters, the priors (prior is pi_k as mentioned in our class, it is hence a 
% 1XK array) of all the last steps for all clusters, data X, the indices of rejected and 
% accepted clusters)
function [ req_p ] = I_q_theta_thetaS( s, K, q, co_var_mat_s, prior_s, mu_s, X, clust_rej, clust_acc )
req_p = 0;
[N,~] = size(X);
for i = 1:K
    marg_prob_q = 0;
    P_q_hs = P_h_hs(q, co_var_mat_s, prior_s, X, mu_s, K);
    for j = 1:N
        marg_prob_q = marg_prob_q + q(i,j); 
    end    
    for j = 1:size(clust_acc(s,:),1)
        req_p = req_p - P_q_hs(i,clust_acc(s,j))*log(P_q_hs(i,clust_acc(s,j)))/(marg_prob_h(X,co_var_mat_s{clust_acc(s,j)},prior_s(1,clust_acc(s,j)),mu_s(clust_acc(s,j),:))*marg_prob_q);
    end
    for j = 1:size(clust_rej(s,:),1)
        req_p = req_p + P_q_hs(i,clust_rej(s,j))*log(P_q_hs(i,clust_rej(s,j)))/(marg_prob_h(X,co_var_mat_s{clust_rej(s,j)},prior_s(1,clust_rej(s,j)),mu_s(clust_rej(s,j),:))*marg_prob_q);
    end
end    
end

