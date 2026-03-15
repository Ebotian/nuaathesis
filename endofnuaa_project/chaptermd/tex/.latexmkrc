# 只生成 PDF
$pdf_mode = 1;

# 主编译器改为 xelatex
$pdflatex = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

