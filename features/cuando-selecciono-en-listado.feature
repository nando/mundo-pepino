Característica: selecciono en un listado

  Escenario: Selecciono una opción de una lista (*select*) 
  ########################################################################
  # Patrón:
  #   Cuando selecciono "_valor_"
  # o:
  #   Cuando selecciono "_valor_" en (el listado de) _campo_
  #
  # Ejemplos:
  #   Cuando selecciono "Hortalizas" en el listado de "Tipos de cultivo"
  #   Cuando selecciono 'Frutales'
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

  Escenario: Selecciono una fecha y hora genérica (sin indicar cual)
  ########################################################################
  # Patrón:
  #   Cuando selecciono "_dia_ de _mes_ de _año_, _hh_:_mm_" como fecha y hora
  #
  # Descripción:
  #   Selecciona fecha y hora en las listas de selección de fecha generadas 
  # con el helper datetime_select de Rails
  #
  #   Está pensado para aquellos casos en los que sólo tenemos una fecha en
  # en el formulario y no queremos mencionar a cual de las fechas existentes
  # nos referimos (porque sólo hay una).
  #   
  #   Las comillas son opcionales.
  #
  # Ejemplo:
  #
  #   Cuando selecciono "25 de diciembre de 2008, 10:00" como fecha y hora
  #
  ########################################################################
    Cuando visito la portada
         Y selecciono "25 de diciembre de 2008, 10:00" como fecha y hora
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#fechayhora con el valor "25/12/2008-10:00"
    Cuando visito la portada
         Y selecciono 1 de setiembre de 1998, 12:46" como fecha y hora
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#fechayhora con el valor "1/9/1998-12:46"
