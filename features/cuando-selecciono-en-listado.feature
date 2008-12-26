Característica: selecciono en un listado

  Escenario: Selecciono una opción de una lista (*select*) 
  ########################################################################
  # Patrón:
  #   Cuando selecciono "_valor_"
  # o:
  #   Cuando selecciono "_valor_" en (el listado de) _campo_
  #
  # Ejemplos:
  #
  # Descripción:
  #
  ########################################################################
    Cuando visito la portada
         Y selecciono "Hortalizas" en el listado de "Tipos de cultivo"
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#orchard_type con el valor "Hortalizas"

    Cuando visito la portada
         Y selecciono 'Frutales' en Tipos de Cultivo
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#orchard_type con el valor "Frutales"

    Cuando visito la portada
         Y selecciono 'Hortalizas'
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#orchard_type con el valor "Hortalizas"

  Escenario: Selecciono una opción de una lista (desde Given) 
    Dado que visito la portada
       Y que selecciono 'Hortalizas'
    Cuando pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#orchard_type con el valor "Hortalizas"
    
