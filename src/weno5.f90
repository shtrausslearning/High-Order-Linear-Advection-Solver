
!     5th Order WENO
      subroutine weno5(um2,um1,u0,up1,up2,u)
      use ModDataTypes
      implicit none
      real(rtype) :: um2, um1, u0, up1, up2, u
      real(rtype) :: eps, gamma1, gamma2, gamma3
      parameter(eps = 1.0d-6, gamma1=1.0d0/10.0d0, gamma2=3.0d0/5.0d0,gamma3=3.0d0/10.0d0)
      real(rtype) :: beta1, beta2, beta3
      real(rtype) :: u1, u2, u3;
      real(rtype) :: w1, w2, w3;

      beta1 = (13.0d0/12.0d0)*(um2 - 2.0d0*um1 + u0)**2.0d0 + (1.0d0/4.0d0)*(um2 - 4.0d0*um1 + 3.0d0*u0)**2.0d0
      beta2 = (13.0d0/12.0d0)*(um1 - 2.0d0*u0 + up1)**2.0d0 + (1.0d0/4.0d0)*(um1 - up1)**2
      beta3 = (13.0d0/12.0d0)*(u0 - 2.0d0*up1 + up2)**2.0d0 + (1.0d0/4.0d0)*(3.0d0*u0 - 4.0d0*up1 + up2)**2.0d0

      w1 = gamma1 / (eps+beta1)**2.0d0
      w2 = gamma2 / (eps+beta2)**2.0d0
      w3 = gamma3 / (eps+beta3)**2.0d0

      u1 = (1.0d0/3.0d0)*um2 - (7.0d0/6.0d0)*um1 + (11.0d0/6.0d0)*u0
      u2 = -(1.0d0/6.0d0)*um1 + (5.0d0/6.0d0)*u0 + (1.0d0/3.0d0)*up1
      u3 = (1.0d0/3.0d0)*u0 + (5.0d0/6.0d0)*up1 - (1.0d0/6.0d0)*up2

      u = (w1 * u1 + w2 * u2 + w3 * u3)/(w1 + w2 + w3)

      return
      end subroutine weno5