
    subroutine error
    use ModDataTypes
    use prmflow
    implicit none
    
    integer :: i
    real(rtype) :: err_l1,err_l2,du
    logical :: exist
    character(80) :: linebuf
    
    f1old(:) = f1(:)  ! store final solution
    f1 = 0.0d0
    call initialCond  ! get initial solution again
    
    err_l1 = 0.0d0
    err_l2 = 0.0d0
    
    do i = 1,nc
!            initial-final
    du = abs( f1(i) - f1old(i) )
    err_l1 = err_l1 + du 
    err_l2 = err_l2 + du**2.0d0
    enddo
    err_l1 = err_l1/dble(nc)
    err_l2 = sqrt(err_l2/dble(nc))
    
    inquire(file='error.dat',exist=exist)
    if(exist)then
    open(111,file='error.dat',status='old',position='append',action='write')
    else
    open(111,file='error.dat',status='new',action='write')
    endif
    
    write(linebuf,*) nc,',',err_l1,',',err_l2
    call del_spaces(linebuf)
    write(111,*) trim(linebuf)
    close(111)
    
    return 
    end subroutine error