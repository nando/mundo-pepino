Característica: relleno el campo

  Escenario: Relleno un campo con un texto (*text* o *textarea*)  
  ########################################################################
  # Patrón: 
  #   Cuando relleno/completo _nombre_ con (el valor)? "_valor_"
  #
  # Ejemplos:
  #   Cuando completo 'nombre' con 'Wadus'
  #   Cuando relleno color con el valor '#FFEEAA'
  #
  # Descripción:
  #   Rellena el campo de texto _nombre_ con _valor_, siendo _nombre_ el 
  # atributo *name* del campo (<input type="text" name="_nombre_" /> o 
  # <textarea name="_nombre_">) .
  #
  #   Las comillas para el valor son obligatorias para el valor (simples
  # o dobles) pero opcionales para el nombre del campo de texto.
  #
  ########################################################################
    Cuando visito la portada
         Y relleno "campo de texto" con "Fertilizador"
         Y pincho en el botón "Galleta de la fortuna"
    Entonces veo el tag div#text_field con el valor "Fertilizador"
    Cuando visito la portada
         Y completo Campo de texto con el valor "Berenjenas"
         Y pincho en el botón "Galleta de la fortuna"
    Entonces veo el tag div#text_field con el valor "Berenjenas"
    
    Cuando visito la portada
         Y completo "área de texto" con el valor "Garbanzos"
         Y pincho en el botón "Galleta de la fortuna"
    Entonces veo el tag div#textarea con el valor "Garbanzos"

  Escenario: Relleno un campo con un texto (desde Given)
    Dado que visito la portada
       Y que completo "área de texto" con el valor "Garbanzos"
    Cuando pincho en el botón "Galleta de la fortuna"
    Entonces veo el tag div#textarea con el valor "Garbanzos"
    
