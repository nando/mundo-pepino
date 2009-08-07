Característica: Solicitud de URL de recurso

  Escenario: Solicitud de la URL asociada al último recurso definido
  ########################################################################
  # Patrón: 
  #   Cuando visito su página
  #
  # Descripción:
  #   Solicita la ruta correspondiente al último recurso (instancia de AR 
  # en @resources) a partir de su mapeo en routes.rb 
  #
  # Ejemplo:
  #   Cuando visito su página
  #
  ########################################################################
    Dado que tenemos un huerto "Esplendoroso"
    Cuando visito su página
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Esplendoroso"

    Dado que tenemos un huerto "Mermado"
       Y que visito su página
    Entonces debo ver la etiqueta H1 con el valor "Página de huerto"
           Y debo ver la etiqueta H2 con el valor "Mermado"
