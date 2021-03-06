
!     UPWIND NUMERICAL FLUX
      subroutine num_flux(x, ul, ur, flux)
      use ModDataTypes
      implicit none
      real(rtype) :: x, ul, ur, flux
      real(rtype) :: convspd, a

      a = convspd(x)

      if(a.gt.0.0d0)then
         flux = a * ul
      else
         flux = a * ur
      endif

      return
      end subroutine num_flux