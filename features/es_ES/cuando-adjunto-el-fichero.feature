Característica: adjunto el fichero
  ATENCIÓN: Este test falla con Rails 2.3.2 debido al escapado que aplica
  ActionController::Integration::Session a las claves de los atributos en
  las peticiones multipart. Ver ticket #2439 para más info (
  https://rails.lighthouseapp.com/projects/8994/tickets/2439)

  Escenario: Adjunto un fichero local en un campo de formulario
  ########################################################################
  # Patrón: 
  #   Cuando adjunto el fichero "_ruta_local_" en _campo_
  #
  ########################################################################
    Cuando visito la portada
         Y adjunto el fichero "Rakefile" en Fichero Adjunto
         Y pincho en el botón "Galleta de la fortuna"
    Entonces veo en la etiqueta div#file_filename el valor "Rakefile"

  Escenario: Adjunto un fichero local en un campo de formulario (como Given)
    Dado que visito la portada
       Y que adjunto el fichero "Rakefile" en Fichero Adjunto
    Cuando pincho en el botón "Galleta de la fortuna"
    Entonces veo en la etiqueta div#file_filename el valor "Rakefile"
