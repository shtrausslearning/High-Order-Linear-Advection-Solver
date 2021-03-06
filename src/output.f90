
!     OUTPUT
      subroutine output
      use ModDataTypes
      use prmflow
      implicit none
      integer i
      character(80) chr

      print*, t
      write(chr,*) './output/sol/sol_',iter,'.dat'
      call del_spaces(chr)
      open(9,file=trim(chr))
      write(9,'(2e24.12)')(x(i),f1(i),i=1,nc)
      close(9)

      return
      end subroutine output
      
      subroutine del_spaces(s)
      character (*), intent (inout) :: s
      character (len=len(s)) tmp
      integer i,j
      j=1
      do i=1,len(s)
      if( s(i:i)==' ') cycle
      tmp(j:j) = s(i:i)
      j=j+1
      enddo
      s = tmp(1:j-1)
      end subroutine del_spaces