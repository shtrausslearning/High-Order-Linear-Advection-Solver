
!   Linear Convection Equation
    program main
    use ModDataTypes
    use prmflow
    implicit none
    integer :: oITER
    parameter( oITER = 25 )
    integer :: i, irk, ierr
    real(rtype)    :: convspd, Mconvspd, f1min, f1max, f1tot
!   #####################################################

    print*, 'nc'
    read(*,*) nc
      
!   1. Allocate global arrays
    ierr=0;allocate( f1(nc),stat=ierr )
    if( ierr /= 0 ) pause 'allocation error f1()'
    ierr=0;allocate( f1old(nc),stat=ierr )
    if( ierr /= 0 ) pause 'allocation error f1old()'
    ierr=0;allocate( x(nc),stat=ierr )
    if( ierr /= 0 ) pause 'allocation error x()'
    ierr=0;allocate( res1(nc),stat=ierr )
    if( ierr /= 0 ) pause 'allocation error res1()'

    rfst=0;rtvd=1;rW3=2;rW5=3;rmuscl=4
     
    xmin = 0.0d0  ! Left end of domain
    xmax = 1.0d0  ! Right end of domain
    tf   = 5.0d0  ! Final time

!   Set to ifirst/itvd/iweno3/iweno5
    rSchm = rfst
!   CFL number
    if(rSchm.eq.rfst)then
     cfl    = 0.9d0
     nrk    = 1
     ark(1) = 0.0d0
    else if(rSchm.eq.rtvd)then
     cfl    = 0.45d0
     nrk    = 2
     ark(1) = 0.0d0
     ark(2) = 0.5d0
    else if(rSchm.eq.rmuscl)then
     cfl    = 0.45d0
     nrk    = 2
     ark(1) = 0.0d0
     ark(2) = 0.5d0
    else if(rSchm.eq.rW3)then
     cfl    = 1.0d0/6.0d0
     nrk    = 3
     ark(1) = 0.0d0
     ark(2) = 3.0d0/4.0d0
     ark(3) = 1.0d0/3.0d0
    else if(rSchm.eq.rW5)then
     cfl    = 1.0d0/12.0d0
     nrk    = 3
     ark(1) = 0.0d0
     ark(2) = 3.0d0/4.0d0
     ark(3) = 1.0d0/3.0d0
    endif
    brk(1:nrk) = 1.0 - ark(1:nrk)
    w1 = cfl
    dx   = (xmax - xmin)/nc

    Mconvspd = 0.0d0
    do i=1,nc
     x(i) = 0.5d0*dx + (i-1)*dx
     Mconvspd = max(Mconvspd, abs(convspd(x(i)-0.5d0*dx)))
    enddo
    dt = cfl*dx/Mconvspd

    print*,"Maximum speed =", Mconvspd
    print*,"Time Step     =", dt

!   set initial condition
    call initialCond
    call compute_range(f1min,f1max,f1tot)
    print*,"Initial function range =", f1min, f1max
    call output

    t = 0.0d0
    iter = 0
    do while(t.lt.tf)
    if(t+dt.gt.tf) dt = tf - t
         
!    RK LOOP
     f1old = f1 ! store old solution
     do irk=1,nrk
      call compute_residual
      call update_solution(irk)
     enddo
         
!    update time/iter
     t = t + dt
     iter = iter + 1
         
!    output related
     if(mod(iter,oITER).eq.0) call output
    call compute_range(f1min,f1max,f1tot)
     write(*,'(i8,4e14.6)') iter,t,f1min,f1max,f1tot

    enddo
    call output
    call error

    stop
    end program main
