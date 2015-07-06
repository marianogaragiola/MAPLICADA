program plot
implicit none
integer :: i, N
real(8), allocatable :: x(:,:)

N = 28464;
allocate(x(1:N,1:6))
open(11,file='./Datos/datos_para_graficar.dat')
open(12,file='./Datos/datos_3d-LaBoca.dat')
do i = 1, N
  read(11,*) x(i,1), x(i,2), x(i,3), x(i,4), x(i,5), x(i,6)
end do

do i = 1, N
  write(12,*) x(i,2), x(i,3), x(i,6)
  if(mod(i,24)==0) then
    write(12,*) ' '
  end if
end do
close(11)
close(12)
deallocate(x)

end program
