Característica: Solicitud de URL de recurso específico a partir del nombre

  Escenario: Solicitud de la URL asociada un recurso del que se facilita su nombre
  ########################################################################
  # Patrón: 
  #   Cuando visito la página del _modelo_ "_nombre_"
  #
  # Descripción:
  #   Solicita la ruta correspondiente a un recurso (instancia de AR 
  # en @resources) del cual se facilita su modelo y su nombre. 
  #
  # Ejemplo:
  #   Cuando visito la página del huerto "H-01"
  #
  ########################################################################
    Dado que tenemos dos huertos "Esplendoroso y Mermado"
    Cuando visito la página del huerto "Esplendoroso"
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Esplendoroso"
    Cuando visito la página del huerto "Mermado"
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Mermado"
