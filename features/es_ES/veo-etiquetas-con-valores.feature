Característica: veo (o no) selectores y (opcionalmente) valores con step-table

  Escenario: Veo (o no) los siguientes selectores
  ########################################################################
  # Patrón:
  #   Entonces (no) debo ver los/las siguientes selectores/etiquetas:
  #     | _selector_1_ |
  #     |     ...      |
  #     | _selector_n_ |
  # o:
  #   Entonces (no) debo ver los/las siguientes selectores/etiquetas:
  #     | CAB.SELECTOR | CAB.VALOR |
  #     | _selector_1_ | _valor_1_ |
  #     |     ...      |    ...    |
  #     | _selector_n_ | _valor_n_ |
  #
  # Descripción:
  #   Comprueba que la existencia de varios selectores a partir de una 
  # step-table. Opcionalmente puede indicarse el valor que deben contener
  # dichos selectores.
  #
  #   Si sólo comprobamos la existencia de selectores NO DEBE utilizarse
  # la primera fila como cabecera (sólo debe existir una columna que se 
  # asume que tiene los selectores que se quieren comprobar)
  # existen en el documento.
  # 
  #   Si comprobamos la existencia de contenido dentro de los selectores
  # SI DEBE utilizarse la primera fila con los literales que más nos
  # gusten para referirnos a "selectores" y "contenido", en este orden
  # (la primera columna será la de selectores, la segunda la de valores).
  #
  ########################################################################
    Cuando visito la portada
    Entonces veo el texto Portada
           Y debo ver las siguientes etiquetas:
             | h1 |
             | div#slogan |
             | form div label |
           Y debo ver los siguientes selectores:
             | Selector       | Valor                  |
             | h1             | Mundo Pepino           |
             | div#slogan     | Todo un huerto para ti |
             | form div label | Nombre de usuario      |
