Creador de documento con Pandoc
===============================

Mediante el uso de [Pandoc](http://pandoc.org/) se pueden obtener diferentes tipos de documento.

En la actualidad, **html** y **pdf**, aunque iré añadiendo más segun los necesite.

Uso
---

Muy sencillo:

    make html

Si tienes instalado el paquete `inotifywait` puedes obtener las salidas cuando hagas cambios en 
cualquier fichero:

    make auto_compile
