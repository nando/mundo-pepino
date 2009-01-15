Característica: selecciono en listado/s

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

  Escenario: Selecciono una fecha y hora sin indicar un campo específico
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
  #   Las comillas para la fecha y la hora son opcionales.
  #
  # Ejemplo:
  #
  #   Cuando selecciono "25 de diciembre de 2008, 10:00" como fecha y hora
  #
  # (continua más abajo)
    Cuando visito la portada
         Y selecciono "25 de diciembre de 2008, 10:00" como fecha y hora
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#fecha-preferida con el valor "25/12/2008"
           Y veo el tag div#hora-preferida con el valor "10:00"
    Cuando visito la portada
         Y selecciono 1 de setiembre de 1998, 12:46" como fecha y hora
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#fecha-preferida con el valor "1/9/1998"
           Y veo el tag div#hora-preferida con el valor "12:46"

  Escenario: Selecciono una fecha y hora en un campo concreto
  ########################################################################
  # Patrón:
  #   Cuando selecciono "_d_ de _m_ de _a_, _h_:_m_" como fecha y hora de? "_label_"
  #
  # Descripción:
  #   Selecciona fecha y hora en las listas de selección de una fecha generada 
  # con el helper datetime_select y etiquetada como _label_.
  #
  #   Podemos hacer referencia a una fecha con una etiqueta concreta cuando 
  # utilicemos varios datetime_select en una página (o si queremos simplemente 
  # escecificar en el texto a cual nos referimos). Por ejemplo, dada la 
  # siguiente vista:
  #
  #   <%= f.label :preferred, 'Preferida' %><br />
  #   <%= f.datetime_select :preferred %>
  #   <%= f.label :alternative, 'Alternativa' %><br />
  #   <%= f.datetime_select :alternative %>
  #
  # Los siguientes pasos seleccionarían dichas fechas en el formulario:
  #
  #   Cuando selecciono 23 de mayo de 1997, 11:20 como fecha y hora "Preferida"
  #   Y selecciono "1 de abril de 2004, 10:30" como fecha y hora "Alternativa"
  #   
  #   Todas las comillas son opcionales. 
  #
  # Ejemplo:
  #   Cuando selecciono "5 de enero de 2008, 10:00" como fecha y hora "Preferida"
  #   Cuando selecciono 1 de abril de 2008, 10:00 como fecha y hora de cosechado
  #
  # (continua más abajo)
    Cuando visito la portada
         Y selecciono "23 de noviembre de 2004, 11:20" como fecha y hora Preferida
         Y selecciono 25 de enero de 2005, 10:30 como fecha y hora de "Alternativa"
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#fecha-preferida con el valor "23/11/2004"
           Y veo el tag div#hora-preferida con el valor "11:20"
           Y veo el tag div#fecha-alternativa con el valor "25/1/2005"
           Y veo el tag div#hora-alternativa con el valor "10:30"

  Escenario: Selecciono una hora
  ########################################################################
  # Patrón:
  #   Cuando selecciono "hh:mm(AM/PM)?" como la? hora
  #
  # Descripción:
  #   Selección de una hora en listas de selección generadas con el helper
  # de Rails time_select.
  #
  #   Dicho helper genera una lista con las horas en formato de 24 horas.
  # Webrat internamente convierte la hora facilitada en formato de 12 horas
  # (p.e. 2:20PM) a formato 24 horas (14:20) y entonces la selecciona.
  #
  # Ejemplos:
  #   Cuando selecciono "2:20PM" como hora
  #   Cuando selecciono 14:20 como la hora
  #
  # (continua más abajo)
    Cuando visito la portada
         Y selecciono 16:23 como hora
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#hora-preferida con el valor "16:23"

    Cuando visito la portada
         Y selecciono "4:23PM" como hora
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#hora-preferida con el valor "16:23"

  Escenario: Selecciono una hora para un campo específico
  ########################################################################
  # Patrón:
  #   Cuando selecciono "hh:mm(AM/PM)?" como la? hora de/l? "_etiqueta_"
  #
  # Descripción:
  #   Selección de una hora en listas de selección generadas con el helper
  # de Rails time_select asociadas con la label _etiqueta_ 
  #   
  #   Todas las comillas son opcionales. 
  #
  # Ejemplos:
  #   Cuando selecciono "2:20PM" como hora "Preferida"
  #   Cuando selecciono 13:20 como la hora del "Cafe"
  #
  # (continua más abajo)
    Cuando visito la pagina de creación de huerto
         Y selecciono 16:23 como hora de Comienzo de riego
         Y selecciono "6:32PM" como hora para la Finalización de riego
         Y pulso el botón "Crear"
    Entonces veo el tag span#riego-comienzo con el valor "16:23"
           Y veo el tag span#riego-fin con el valor "18:32"

    Cuando visito la pagina de creación de huerto
         Y selecciono 6:23AM como hora para el "Comienzo de riego"
         Y selecciono "16:32" como hora de la "Finalización de riego"
         Y pulso el botón "Crear"
    Entonces veo el tag span#riego-comienzo con el valor "6:23"
           Y veo el tag span#riego-fin con el valor "16:32"

  Escenario: Selecciono una fecha
  ########################################################################
  # Patrón:
  #   Cuando selecciono "_dia_ de _mes_ de _año_" como la? fecha
  #
  # Descripción:
  #   Selección de una fecha en listas de selección generadas con el helper
  # de Rails date_select.
  #
  # Ejemplos:
  #   Cuando selecciono "28 de marzo de 2005" como fecha
  #   Cuando selecciono 1 de mayo de 1995 como la fecha
  #
  # (continua más abajo)
    Cuando visito la portada
         Y selecciono "28 de marzo de 2005" como fecha
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#fecha-preferida con el valor "28/3/2005"

    Cuando visito la portada
         Y selecciono "2 de agosto de 2008" como la fecha
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#fecha-preferida con el valor "2/8/2008"

  Escenario: Selecciono una fecha para un campo específico
  ########################################################################
  # Patrón:
  #   Cuando selecciono "_d_ de _m_ de _a_" como la? fecha de/para? el/la? "_etiqueta_"
  #
  # Descripción:
  #   Selección de una fecha en listas de selección generadas con el helper
  # de Rails date_select asociadas con la label _etiqueta_
  #   
  #   Todas las comillas son opcionales. 
  #
  # Ejemplos (equivalentes):
  #   Cuando selecciono "28 de marzo de 2005" como fecha nacimiento
  #   Cuando selecciono "28 de marzo de 2005" como fecha "nacimiento"
  #   Cuando selecciono "28 de marzo de 2005" como fecha de nacimiento
  #   Cuando selecciono 28 de marzo de 2005 como la fecha del nacimiento
  #   Cuando selecciono 28 de marzo de 2005 como la fecha para el nacimiento
  #
  ########################################################################
    Cuando visito la portada
         Y selecciono 1 de octubre de 2009 como fecha para la vendimia
         Y selecciono 15 de marzo de 2010 como fecha de "poda"
         Y pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#fecha-de-vendimia con el valor "1/10/2009"
           Y veo el tag div#fecha-de-poda con el valor "15/3/2010"

  Escenario: Selecciono una opciones desde pasos Given
    Dado que visito la portada
       Y que selecciono 25 de enero de 2009, 10:30 como fecha y hora
       Y que selecciono "23 de noviembre de 2009, 11:20" como fecha y hora "Alternativa"
       Y que selecciono 1 de marzo de 2009 como fecha de la poda
       Y que selecciono 'Hortalizas'
    Cuando pulso el botón "Galleta de la fortuna"
    Entonces veo el tag div#orchard_type con el valor "Hortalizas"
           Y veo el tag div#fecha-preferida con el valor "25/1/2009"
           Y veo el tag div#hora-preferida con el valor "10:30"
           Y veo el tag div#fecha-alternativa con el valor "23/11/2009"
           Y veo el tag div#hora-alternativa con el valor "11:20"
           Y veo el tag div#fecha-de-poda con el valor "1/3/2009"
