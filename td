#!/usr/bin/tcsh

set wd = `pwd`
set hdr = `tail -n 2 $wd/output.dat | grep "%" `
set ir1 = `tail -n 2 $wd/output.dat | grep "%" | awk '{print $2}'`
sleep 10;
set ir2 = `tail -n 2 $wd/output.dat | grep "%" | awk '{print $2}'`
set itmax = `tail -n 2 $wd/output.dat | grep "%" | awk '{print $7}'`
set di = `sub $ir2 $ir1`
set di = `div $di 10.0`

if ($ir2 == "") then
  echo DONE!
  tail -n 2 $wd/output.dat
else
  set il = `sub $itmax $ir2`
  #set dt = `div $il 12.0`
  set dt = `div $il $di`
  set td = `sec2hms $dt`
  set ft = `future $dt`
  echo wd = $wd
  echo $hdr
  echo ir = $ir2
  echo itmax = $itmax
  echo iters left = $il
  echo di/dt = $di
  echo time left = $td
  echo done at = $ft
  pbar $ir2 $itmax
endif
