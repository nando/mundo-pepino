Característica: relleno los campos

  Antecedentes:
    Dado que visito la portada

  Esquema del escenario: Relleno varios campos (*text* o *textarea*) desde una step-table
  ########################################################################
  # Patrón: 
  #   Cuando relleno/completo (los siguientes? campos)?:
  #
  # Ejemplos:
  #   Cuando completo:
  #     | Campo   | Valor   |
  #     | Nombre  | Lechuga |
  #     | Color   | #00FF00 |
  #
  # Descripción:
  #   Rellena los campos indicados en la primera columna con los valores
  # de la segunda.
  #
  ########################################################################
    Cuando <relleno>:
      | Campo          | Valor        |
      | campo de texto | Fertilizador |
      | área de texto  | Garbanzos    |
    Y pincho en el botón "Galleta de la fortuna"
    Entonces veo el tag div#text_field con el valor "Fertilizador"
           Y veo el tag div#textarea con el valor "Garbanzos"
  Ejemplos:
    | relleno                        |
    | relleno                        |
    | completo                       |
    | relleno los campos             |
    | completo los siguientes campos |
