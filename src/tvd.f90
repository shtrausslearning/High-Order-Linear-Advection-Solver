
!     TVD
      subroutine tvd(um1,u0,up1,u)
      use ModDataTypes
      implicit none
      real(rtype) :: um1, u0, up1, u

      real(rtype) :: dul, dur, duc, beta, minmod
      parameter(beta=2.0d0)

      dul = u0  - um1
      dur = up1 - u0
      duc = up1 - um1

      u = u0 + 0.5d0 * minmod(0.5d0*duc, beta*dul, beta*dur)

      return
      end subroutine tvd