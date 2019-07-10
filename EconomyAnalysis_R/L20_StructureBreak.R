

## 회귀 직선에서 beta는 시간에 따라 변하지 고정되어 있지 않음.
# 바로 Structure Breadk(ex.외환위기)가 일어나 beta도 변화 할것. 
# 다만 갑자기 떨어져서 변하는것이 아니라 점차 연속적으로 조금씩 변할것.
# 회귀 분석에서 점차 변하는 beta를 어떻게 표현할 것인가.

#    Yt = alpha + beta(t) Xt + Ut
# ->  Yt = alpha + (c0 + c1t + c1t^2) Xt + Ut
# ->  Yt = alpha + c0 Xt + c1(t Xt)+ c1(t^2 Xt) + Ut

# 즉 beta(t) = p∑i=1 (Ci t^i-1)

# 하지만 신뢰구간(표준오차)가 없는 beta는 무의미 생각해보자.

# conditional t시점의 분산.
# Var( beta_hat(t) | t ) = Var(c0_hat + c1_hat t + c1_hat t^2)

# beta_hat = (1 , t , t^2)' %*% ( c0_hat , c1_hat , c2_hat )
# Var(beta_hat) = Var(tt'c_hat) = tt'Var(c_hat)t't


## Series estimator (S'eve) : 즉 위와 같이 쭉 나열해서 추정치를 표현하는 것을 말함 ( Non parametrics)
# Power series : 위와 같이 제곱으로 쭉쭉나감 (각각 자기들이 상관관계를 가짐으로 잘 안쓰임)
# Fourier series :  ──┐
# Legendre series : ─┘ 위 두개는 orthonormal 하므로 좀더 적절

# =================================================================================================

#  Yt = alpha + beta(t) Xt + Ut 
# Ut ~ iid h(t) : MLE사용

#  Yt = alpha + beta(t) Xt + Ut
# Ut = sqrt(ht)ηt
# ηt ~ N(0,1)
# ht = C0 + C1 ht + c2 u^2(t-1)  : Garch 형태 ->
