
!   LHS/RHS State Reconstruction
    subroutine reconstruct(um2,um1,u0,up1,up2,u)
    use ModDataTypes
    use prmflow
    implicit none
    real(rtype) :: um2, um1, u0, up1, up2, u

    if(rSchm.eq.rfst)then
      u = u0
    else if(rSchm.eq.rtvd)then
      call tvd(um1,u0,up1,u)
    elseif( rSchm == rmuscl )then
      call muscl(um1,u0,up1,u)
    else if(rSchm.eq.rW3)then
      call weno3(um1,u0,up1,u)
    else if(rSchm.eq.rW5)then
      call weno5(um2,um1,u0,up1,up2,u)
    endif

    return
    end subroutine reconstruct