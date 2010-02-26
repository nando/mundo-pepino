# language: es
Característica: leo (o no) una serie de textos expresados en step-table

  Escenario: Leo (o no) los siguientes textos
  ########################################################################
  # Patrón:
  #   Entonces (no) debo leer los siguientes textos:
  # o:
  #   Entonces (no) leo los siguientes textos:
  #
  # Descripción:
  #   Comprueba que los textos de la step-table (incluída la primera fila)
  # existen en el documento, una vez quitadas todas las etiquetas HTML del documento
  #
  ########################################################################
    Dado que tenemos un huerto "Esplendoroso"
        Y que dicho huerto tiene como hora de comenzar a regar "6:30"
        Y que dicho huerto tiene como hora de terminar de regar "7:30"
    Cuando visito su página
	Entonces debo leer los siguientes textos:
        | Página de huerto Esplendoroso |
        | De 6:30                       |
        | a 7:30                        |
	  Y no debo leer los siguientes textos:
        | Cucumber |
        | Rocks    |
