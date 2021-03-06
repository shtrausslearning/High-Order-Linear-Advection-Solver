
!     Compute Residual
      subroutine compute_residual
      use ModDataTypes
      use prmflow
      implicit none
      
      integer i
      real(rtype) ::    f1l(nc+1), f1r(nc+1), flux1
      real(rtype) ::  pstar, mini, maxi, theta1, theta2, theta

      res1(:) = 0.0d0 ! reset
!     Compute interface values

!     First face
      call reconstruct(f1(nc-2),f1(nc-1),f1(nc),f1(1),f1(2),f1l(1))
      call reconstruct(f1(3),f1(2),f1(1),f1(nc),f1(nc-1),f1r(1))
!     Second face
      call reconstruct(f1(nc-1),f1(nc),f1(1),f1(2),f1(3),f1l(2))
      call reconstruct(f1(4),f1(3),f1(2),f1(1),f1(nc),f1r(2))
!     Third face
      call reconstruct(f1(nc),f1(1),f1(2),f1(3),f1(4),f1l(3))
      call reconstruct(f1(5),f1(4),f1(3),f1(2),f1(1),f1r(3))

!     ALL FACES IN BETWEEN -------------------------------------------
      do i=3,nc-3
      call reconstruct(f1(i-2),f1(i-1),f1(i),f1(i+1),f1(i+2),f1l(i+1))
      call reconstruct(f1(i+3),f1(i+2),f1(i+1),f1(i),f1(i-1),f1r(i+1))
      enddo

!     Third face from end
      call reconstruct(f1(nc-4),f1(nc-3),f1(nc-2),f1(nc-1),f1(nc),f1l(nc-1))
      call reconstruct(f1(1),f1(nc),f1(nc-1),f1(nc-2),f1(nc-3),f1r(nc-1))
!     penultimate face
      call reconstruct(f1(nc-3), f1(nc-2), f1(nc-1), f1(nc),f1(1),f1l(nc))
      call reconstruct(f1(2), f1(1), f1(nc), f1(nc-1), f1(nc-2),f1r(nc))
!     Last face
      f1l(nc+1) = f1l(1)
      f1r(nc+1) = f1r(1)

!     Apply positivity limiter
      if(rSchm.eq.rw3.or.rSchm.eq.rw5)then
      do i=1,nc
        pstar = (f1(i) - w1*f1r(i) - w1*f1l(i+1))/(1.0d0 - 2.0d0*w1)
        mini = min(pstar, min(f1r(i), f1l(i+1)))
        maxi = max(pstar, max(f1r(i), f1l(i+1)))
        theta1 = abs(1.0d0-f1(i))/(abs(maxi-f1(i))+1.0d-14)
        theta2 = abs(0.0d0-f1(i))/(abs(mini-f1(i))+1.0d-14)
        theta  = min(1.0d0, min(theta1, theta2))
        f1r(i) = theta*(f1r(i) - f1(i)) + f1(i)
        f1l(i+1) = theta*(f1l(i+1) - f1(i)) + f1(i)
      enddo
      endif

!     Left state of first face and right state of last face
      f1l(1) = f1l(nc+1)
      f1r(nc+1) = f1r(1)

!     Compute fluxes

!     boundary face
      call num_flux(x(1)-0.5d0*dx, f1l(1), f1r(1), flux1)
      res1(nc) = res1(nc) + flux1
      res1(1)  = res1(1)  - flux1

!     all other faces
      do i=1,nc-1
         call num_flux(x(i+1)-0.5d0*dx, f1l(i+1), f1r(i+1), flux1)
         res1(i)   = res1(i)   + flux1
         res1(i+1) = res1(i+1) - flux1
      enddo

      res1 = res1/dx

      return
      end subroutine compute_residual