Característica: leo (o no) un texto

  Escenario: Leo (o no) un texto 
  ########################################################################
  # Patrón:
  #   Entonces (no) debo leer el texto _texto_
  # o:
  #   Entonces (no) leo el texto _texto_
  #
  # Ejemplos:
  #   Entonces debo leer el texto "IVA incluido"
  #   Entonces leo el texto "IVA no incluido"
  #
  # Descripción:
  #   Comprueba que, quitando todas las etiquetas HTML del documento, encontramos _texto_
  #
  ########################################################################
    Dado que tenemos un huerto "Esplendoroso"
	Y que dicho huerto tiene como hora de comenzar a regar "6:30"
	Y que dicho huerto tiene como hora de terminar de regar "7:30"
    Cuando visito su página
	Entonces leo el texto "Página de huerto Esplendoroso"
	Y debo leer el texto "De 6:30"
	Y debo leer el texto "a 7:30"
	Y no debo leer el texto Cucumber
	Y no leo el texto "Rocks"
