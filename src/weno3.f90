
!     3rd Order WENO
      subroutine weno3(um1,u0,up1,u)
      use ModDataTypes
      implicit none
      real(rtype) :: um1, u0, up1, u
      real(rtype) :: eps, gamma1, gamma2
      parameter(eps = 1.0d-6, gamma1=1.0d0/3.0d0, gamma2=2.0d0/3.0d0)
      real(rtype) :: beta1, beta2
      real(rtype) :: u1, u2
      real(rtype) :: w1, w2

      beta1 = (um1 - u0)**2.0d0
      beta2 = (up1 - u0)**2.0d0

      w1 = gamma1 / (eps+beta1)**2.0d0
      w2 = gamma2 / (eps+beta2)**2.0d0

      u1 = (3.0d0/2.0d0)*u0 - (1.0d0/2.0d0)*um1
      u2 = (u0 + up1)/2.0d0

      u = (w1 * u1 + w2 * u2)/(w1 + w2)

      return
      end subroutine weno3
