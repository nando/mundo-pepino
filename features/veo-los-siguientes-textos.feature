Característica: veo (o no) una serie de textos expresados en step-table

  Escenario: Veo (o no) los siguientes textos
  ########################################################################
  # Patrón:
  #   Entonces (no) debo ver los siguientes textos:
  # o:
  #   Entonces (no) veo los siguientes textos:
  #
  # Descripción:
  #   Comprueba que los textos de la step-table (incluída la primera fila)
  # existen en el documento.
  #
  ########################################################################
    Cuando visito la portada
    Entonces veo el texto Portada
           Y debo ver los siguientes textos:
             | Mundo Pepino                                   |
             | app.welcome.title                              |
             | app.welcome.interpolated,{ :name => 'Nombre' } |
           Y no debo ver los siguientes textos:           
             | Cucumber |
             | Rocks    |
