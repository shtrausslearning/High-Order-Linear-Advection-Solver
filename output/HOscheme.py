import numpy as np

# weno reconstruction function (3 stencils)
def weno3(um1,u0,up1):
	
	eps = 1.0e-6
	gamma1 = 1.0/3.0
	gamma2 = 2.0/3.0
	
	beta1 = (um1 - u0)**2
	beta2 = (up1 - u0)**2

	w1 = gamma1 / (eps+beta1)**2
	w2 = gamma2 / (eps+beta2)**2

	u1 = (3.0/2.0)*u0 - (1.0/2.0)*um1
	u2 = (u0 + up1)/2.0

	return (w1 * u1 + w2 * u2)/(w1 + w2)

# weno reconstruction function (5 stencils)
def weno5(um2,um1,u0,up1,up2):
	
	eps = 1.0e-6
	gamma1 = 1.0/10.0
	gamma2 = 3.0/5.0
	gamma3 = 3.0/10.0
	
	beta1 = (13.0/12.0)*(um2 - 2.0*um1 + u0)**2 + (1.0/4.0)*(um2 - 4.0*um1 + 3.0*u0)**2
	beta2 = (13.0/12.0)*(um1 - 2.0*u0 + up1)**2 + (1.0/4.0)*(um1 - up1)**2
	beta3 = (13.0/12.0)*(u0 - 2.0*up1 + up2)**2 + (1.0/4.0)*(3.0*u0 - 4.0*up1 + up2)**2
	
	w1 = gamma1 / (eps+beta1)**2
	w2 = gamma2 / (eps+beta2)**2
	w3 = gamma3 / (eps+beta3)**2

	u1 = (1.0/3.0)*um2 - (7.0/6.0)*um1 + (11.0/6.0)*u0
	u2 = -(1.0/6.0)*um1 + (5.0/6.0)*u0 + (1.0/3.0)*up1
	u3 = (1.0/3.0)*u0 + (5.0/6.0)*up1 - (1.0/6.0)*up2

	return (w1 * u1 + w2 * u2 + w3 * u3)/(w1 + w2 + w3)
	
def muscl(um1,u0,up1):
	
	kkk = 1.0/3.0
	dm = u0 - um1
	dp = up1 - u0
	
	return u0 + 0.25*( (1.0-kkk)*dm + (1.0+kkk)*dp )

def tvd(um1,u0,up1):
	
	beta = 2.0
	
	dul = u0 - um1
	dur = up1 - u0
	duc = up1 - um1
	
	dd = minmod(0.5*duc,beta*dul,beta*dur)

	return u0 + 0.5*dd
	
def minmod(a,b,c):

	if( a*b < 0.0 or b*c < 0.0 ):
		minmod = 0.0
	else:
		minmod = np.sign(a) * min( min(abs(a),abs(b)),abs(c)    )
		
	return minmod
	
		