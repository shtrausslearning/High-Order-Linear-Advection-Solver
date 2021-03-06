
    module ModDataTypes
    implicit none

    integer, parameter :: chrlen = 256         !< length of strings
    integer, parameter :: rtype  = kind(1.D0)  !< reals with double precision

    end module ModDataTypes

    module prmflow
    use ModDataTypes
    implicit none

!   Global Constants
    integer :: nc
    integer :: rfst, rtvd, rW3, rW5, rSchm, rmuscl
    real(rtype) :: w1,dx,xmin,xmax
    real(rtype) :: ark(3),brk(3)
    real(rtype) :: tf,dt,cfl
    real(rtype) :: t
    integer :: iter, nrk

!   Global Arrays
    real(rtype), allocatable :: f1(:)
    real(rtype), allocatable :: f1old(:)
    real(rtype), allocatable :: res1(:)
    real(rtype), allocatable :: x(:)

    end module prmflow