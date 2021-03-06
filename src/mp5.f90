! Scheme of Suresh and Huynh
    subroutine mp5(um2,um1,u0,up1,up2,u)
    use ModDataTypes
   implicit none
   real(rtype) :: um2, um1, u0, up1, up2, u
   real(rtype), parameter :: eps = 1.0d-13, alpha = 4.0d0
   real(rtype) :: ump, d0, dm1, dp1, dlm4, drm4, uul, uav, umd, ulc
   real(rtype) :: umin, umax, minmod2, minmod3, minmod4, median

   u = (2.0d0*um2 - 13.0d0*um1 + 47.0d0*u0 + 27.0d0*up1 - 3.0d0*up2)/60.0d0
   ump = u0 + minmod2(up1-u0, alpha*(u0-um1))
   if ((u - u0)*(u - ump) < eps) then
      return
   endif
   d0 = um1 + up1 - 2.0d0*u0
   dm1= um2 + u0  - 2.0d0*um1
   dp1= u0  + up2 - 2.0d0*up1
   dlm4 = minmod4(4.0d0*dm1 - d0, 4.0d0*d0-dm1, dm1, d0)
   drm4 = minmod4(4.0d0*d0 - dp1, 4.0d0*dp1-d0, d0,  dp1)
   uul = u0 + alpha*(u0 - um1)
   uav = 0.5d0*(u0 + up1)
   umd = uav - 0.5d0*drm4
   ulc = u0 + 0.5d0*(u0 - um1) + (4.0d0/3.0d0)*dlm4
   umin = max(min(u0,up1,umd), min(u0,uul,ulc))
   umax = min(max(u0,up1,umd), max(u0,uul,ulc))
   u = median(u, umin, umax)
end subroutine mp5

    real(rtype) function minmod4(a, b, c, d)
    use ModDataTypes
   implicit none

   real(rtype) :: a, b, c, d

   if(a*b > 0.0d0 .and. b*c > 0.0d0 .and. c*d > 0.0d0)then
      minmod4 = sign(1.0d0, a) * min(abs(a), abs(b), abs(c), abs(d))
   else
      minmod4 = 0.0d0
   endif

end function minmod4

real(rtype) function minmod2(a, b)
use ModDataTypes
   implicit none

   real(rtype) :: a, b

   if(a*b > 0.0d0)then
      minmod2 = sign(1.0d0, a) * min(abs(a), abs(b))
   else
      minmod2 = 0.0d0
   endif

end function minmod2

real(rtype) function median(a,b,c)
use ModDataTypes
    implicit none
    real(rtype) :: a, b, c
    real(rtype) :: minmod2

    median = a + minmod2(b-a, c-a)
end function median