ml /c mode13x.asm
ml /c point.asm
ml /c svgamode.asm
ml /c banks.asm
\msc\bin\cl -AS -Oas -Gs -Zl -Zp -FPa -Zi -c example.c
link example+mode13x+point+svgamode+banks,example,example,\msc\lib\slibca;

