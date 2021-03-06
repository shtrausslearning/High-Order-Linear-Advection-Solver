
!     MUSCL
      subroutine muscl(um1,u0,up1,u)
      use ModDataTypes
      implicit none
      real(rtype) :: um1, u0, up1, u
      real(rtype),parameter :: kkk=1.0d0/3.0d0

      u = u0 + 0.25d0*( (1.0d0-kkk)*(u0 - um1) + (1.0d0+kkk)*(up1 - u0) )

      return
      end subroutine muscl