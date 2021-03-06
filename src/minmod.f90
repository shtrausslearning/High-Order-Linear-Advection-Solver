
!     MinMod Function
      real(rtype) function minmod(a, b, c)
      use ModDataTypes
      implicit none
      real(rtype) :: a, b, c

      if(a*b.lt.0.0d0.or.b*c.lt.0.0d0)then
         minmod = 0.0
      else
         minmod = sign(1.0d0, a) * min(min(abs(a), abs(b)), abs(c))
      endif

      return
      end