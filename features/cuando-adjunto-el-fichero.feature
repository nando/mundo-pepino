Característica: adjunto el fichero

  Escenario: Adjunto un fichero local en un campo de formulario
  ########################################################################
  # Patrón: 
  #   Cuando adjunto el fichero "_ruta_local_" en _campo_
  #
  ########################################################################
    Cuando visito la portada
         Y adjunto el fichero "config/database.yml" en file_field
         Y pincho en el botón "Galleta de la fortuna"
    Entonces veo en la etiqueta div#file_filename el valor "database.yml"
