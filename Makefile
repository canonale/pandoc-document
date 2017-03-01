css=-c https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css \
-c ./documentos/blogme.css #\

footer=./documentos/footer.html
header=./documentos/header.html
chap_folder?=./Capítulos
HTML_SED_FILE?=./documentos/html.sed
OUT_HTML?=out.html
MD_IN_FORMAT?=markdown_phpextra+pipe_tables+auto_identifiers

all: html_proceso


html_proceso: mix_chapters html delete_mix

mix_chapters:
	@cat $(chap_folder)/*.md > tmp_chapters_mix.md
delete_mix:
	@rm -f tmp_chapters_mix.md

html:
	@pandoc -s -S $(css) -A $(footer) -B $(header) -f $(MD_IN_FORMAT)  tmp_chapters_mix.md -o $(OUT_HTML)
	@sed -f $(HTML_SED_FILE) -i  $(OUT_HTML)

list_links: mix_chapters 
	@sed "s;\(!*\[[^]]\+\]\[\]\);\n\t\1\n;g" tmp_chapters_mix.md | grep -P "^\t"
	@make delete_mix

auto_compile:
	@while inotifywait -q -e close_write -r ./Capítulos/;do make;done
