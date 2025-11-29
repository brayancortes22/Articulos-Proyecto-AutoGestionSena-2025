# latexmk configuration for unified outdir and shell-escape
$out_dir = 'build';
$bibtex_use = 2;  # Use biber instead of bibtex by default
$pdflatex  = 'pdflatex -interaction=nonstopmode -shell-escape %O %S';
$lualatex  = 'lualatex -interaction=nonstopmode -shell-escape %O %S';
$xelatex   = 'xelatex -interaction=nonstopmode -shell-escape %O %S';

# Forzar conversión de .xdv a .pdf con xdvipdfmx (necesario para ACM y APA7)
add_cus_dep('xdv', 'pdf', 0, 'xdvipdfmx_convert');
sub xdvipdfmx_convert {
	my ($base_name, $path) = @_; # $path incluye el nombre base
	return system("xdvipdfmx -o $base_name.pdf $base_name.xdv");
}