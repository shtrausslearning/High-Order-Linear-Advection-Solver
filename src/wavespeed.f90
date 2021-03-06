
!     WAVE SPEED
      real(rtype) function convspd(x)
      use ModDataTypes
      implicit none
      real(rtype) :: x

      convspd = 1.0d0
      !convspd = x

      return
      end function convspd