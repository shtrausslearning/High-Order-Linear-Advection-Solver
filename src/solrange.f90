
!     COMPUTE RANGE OF SOLUTION
      subroutine compute_range(f1min,f1max, f1tot)
      use ModDataTypes
      use prmflow
      implicit none
      real(rtype),intent(out) :: f1min, f1max, f1tot
      integer i

      f1min = 1.0d20
      f1max =-1.0d20
      f1tot = 0.0d0

      do i=1,nc
       f1min = min(f1min, f1(i))
       f1max = max(f1max, f1(i))
       f1tot = f1tot + f1(i) * dx
      enddo

      return
      end subroutine compute_range