::========================================================================================
::call clean.bat
::========================================================================================
::call build.bat
::========================================================================================
::cd ../sim
:: vsim -gui -do run.do
::vsim -gui -do "do run.do %1"
vsim -c -do "do run.do %1" 