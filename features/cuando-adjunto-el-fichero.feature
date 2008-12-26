Característica: adjunto el fichero

  Escenario: Adjunto un fichero local en un campo de formulario
  ########################################################################
  # Patrón: 
  #   Cuando adjunto el fichero "_ruta_local_" en _campo_
  #
  ########################################################################
    Cuando visito la portada
         Y adjunto el fichero "config/database.yml" en Fichero Adjunto
         Y pincho en el botón "Galleta de la fortuna"
    Entonces veo en la etiqueta div#file_filename el valor "database.yml"

  Escenario: Adjunto un fichero local en un campo de formulario (como Given)
    Dado que visito la portada
       Y que adjunto el fichero "config/database.yml" en Fichero Adjunto
    Cuando pincho en el botón "Galleta de la fortuna"
    Entonces veo en la etiqueta div#file_filename el valor "database.yml"
