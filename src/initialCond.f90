
!     Initial Condition
      subroutine initialCond
      use ModDataTypes
      use prmflow
      implicit none

      integer i
      real(rtype) ::   pi
      parameter(pi=4.0d0*atan(1.0d0))

      do i=1,nc
      f1(i) = sin(2.0d0*pi*x(i))**2.0d0
      !f1(i) = sin(pi*x(i))
      
!      f1(i) = 0.0
!      if( x(i) .ge. (1.0/3.0) .and. x(i) .lt. (2.0/3.0)  )then
!      f1(i) = 1.0
!      endif
      
      enddo
      

      return
      end subroutine initialCond