css=-c ./documentos/bootstrap.min.css \
	-c ./documentos/blogme.css 

footer=./documentos/footer.html
topper=./documentos/topper.html
header=./documentos/header.html
chap_folder?=./Capítulos
HTML_SED_FILE?=./documentos/html.sed
OUT_HTML?=Tareas-salida.html
OUT_PDF?=Tareas-salida.pdf
OUT_MAIL?=Tareas-salida.eml
MD_IN_FORMAT?=markdown_phpextra+pipe_tables+auto_identifiers+pandoc_title_block

LATEXT_TEMPLATE=./documentos/plantilla-pdf.tex

all: html_proceso


html_proceso: mix_chapters html delete_mix

mix_chapters:
	@cat $(chap_folder)/*.md > tmp_chapters_mix.md
delete_mix:
	@rm -f tmp_chapters_mix.md

html:
	@pandoc -s -S $(css) -A $(footer) -B $(topper) -H $(header) -f $(MD_IN_FORMAT)  tmp_chapters_mix.md -o $(OUT_HTML)
	@sed -f $(HTML_SED_FILE) -i  $(OUT_HTML)

list_links: mix_chapters 
	@sed "s;\(!*\[[^]]\+\]\[\]\);\n\t\1\n;g" tmp_chapters_mix.md | grep -P "^\t"
	@make delete_mix

auto_compile:
	@while inotifywait -q -e close_write -r ./Capítulos/;do make;done
pdf: mix_chapters
	@pandoc -N --template=$(LATEXT_TEMPLATE)  --variable mainfont="Helvetica65-Medium" --variable fontsize=12pt --variable version=1.17.2 tmp_chapters_mix.md --latex-engine=xelatex --toc -o $(OUT_PDF)
	@make delete_mix

email: mix_chapters
	@./documentos/docu2b64.sh tmp_chapters_mix.md
	@cp ./documentos/base-mail.eml $(OUT_MAIL)
	@pandoc -s -A $(footer) -B $(topper) -H $(header) -f $(MD_IN_FORMAT)  tmp_chapters_mix.md -o $(OUT_HTML)
	@sed -f $(HTML_SED_FILE) -i  $(OUT_HTML)
	@base64 $(OUT_HTML) >> $(OUT_MAIL)
	@make delete_mix



