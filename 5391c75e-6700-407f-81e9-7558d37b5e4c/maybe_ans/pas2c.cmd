@echo off
for %%f in (*.pas) do (
    if exist "%%f" (
        ren "%%f" "%%~nf.c"
    )
)