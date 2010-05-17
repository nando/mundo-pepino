# language: es
Característica: veo (o no) una serie de textos expresados en step-table dentro de un selector concreto

  Escenario: Veo (o no) los siguientes textos
  ########################################################################
  # Patrón:
  #   Entonces (no) veo los siguientes textos dentro de la etiqueta "_tag_":
  #     | texto 1 |
  #     |   ...   |
  #     | texto n |
  #
  # Descripción:
  #   Comprueba que los textos de la step-table (incluída la primera fila)
  # existen dentro del selector indicado.
  #
  ########################################################################
    Cuando visito la portada
           Y debo ver los siguientes textos dentro de la etiqueta "div.navigation_links":
             | Registro                     |
             | Entra                        |
             | Listado de todos los huertos |
             | /entra/i                     |
           Y no debo ver los siguientes textos dentro de la etiqueta "div.navigation_links":
             | Mundo Pepino      |
             | app.welcome.title |
             | /entra/           |
