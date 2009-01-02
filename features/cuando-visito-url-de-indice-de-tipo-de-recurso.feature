Característica: Solicitud de URL de índice (index) de recursos de un modelo

  Escenario: Solicitud del índice de un tipo de recurso (index)
  ########################################################################
  # Patrón: 
  #   Cuando visito el/la página/portada/coleccion/listado/índice de _modelo_
  #
  # Descripción:
  #   Solicita la ruta correspondiente al formulario de alta de un 
  # recurso a partir del mapeo de su modelo en routes.rb 
  #
  # Ejemplos:
  #   Cuando visito la página de Huertos
  #   Cuando visito la portada de Huertos
  #
  ########################################################################
    Cuando visito la Página de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"

    Cuando visito la portada de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"

    Cuando visito la colección de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"

    Cuando visito el listado de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"

    Cuando visito el índice de Huertos
    Entonces debo ver la etiqueta H1 con el valor "Listado de Huertos"


