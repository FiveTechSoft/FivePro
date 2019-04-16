ml /c mode13x.asm
ml /c xpoint.asm
ml /c svgamode.asm
ml /c banks.asm
ml /c line.asm
\msc\bin\cl -AS -Oas -Gs -Zl -Zp -FPa -Zi -c sticks.c
link sticks+mode13x+xpoint+svgamode+banks+line,sticks,sticks,\msc\lib\slibca;

