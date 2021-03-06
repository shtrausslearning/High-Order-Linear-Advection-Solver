
!     3-stage 3-order SSP-RK scheme
      subroutine update_solution (irk)
      use ModDataTypes
      use prmflow
      implicit none
      integer irk

      f1 = ark(irk)*f1old + brk(irk)*(f1 - dt * res1)

      return
      end subroutine update_solution