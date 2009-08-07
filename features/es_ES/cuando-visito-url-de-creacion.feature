Característica: Solicitud de URL de creación de recurso

  Escenario: Solicitud de la URL asociada a la creación de un recurso
  ########################################################################
  # Patrón: 
  #   Cuando visito la página de creación de _modelo_
  # o:
  #   Cuando visito la página de nuevo/a _modelo_
  # o:
  #   Cuando visito la página de alta de _modelo_
  #
  # Descripción:
  #   Solicita la ruta correspondiente al formulario de alta de un 
  # recurso a partir del mapeo de su modelo en routes.rb 
  #
  # Ejemplos:
  #   Cuando visito la página de alta de Huerto
  #   Cuando visito la página de nuevo Huerto
  #
  ########################################################################
    Cuando visito la página de creación de huerto
    Entonces debo ver la etiqueta H1 con el valor "Alta de Huerta"
    Cuando visito la página de alta de huerto
    Entonces debo ver la etiqueta H1 con el valor "Alta de Huerta"
    Cuando visito la página de nueva huerta
    Entonces debo ver la etiqueta H1 con el valor "Alta de Huerta"

    Dado que visito la página de creación de huerto
    Entonces debo ver la etiqueta H1 con el valor "Alta de Huerta"
