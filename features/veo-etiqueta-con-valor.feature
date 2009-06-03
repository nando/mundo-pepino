Característica: etiqueta/selector con valor

  Escenario: Veo (o no) una etiqueta HTML opcionalmente con un contenido concreto 
  ########################################################################
  # Patrón: 
  #   Entonces (no) debo ver la etiqueta _selector_( con el valor "_valor_")
  # o:
  #   Entonces (no) debo ver en la etiqueta _selector_( el valor "_valor_")
  # o:
  #   Entonces (no) veo la etiqueta _selector_( con el valor "_valor_")
  # o:
  #   Entonces (no) veo el tag _selector_( con el valor "_valor_")
  #
  # Descripción:
  #   Comprueba la existencia o inexistencia de una etiqueta/selector que
  # opcionalmente debe tener un contenido concreto (case sensitive).
  # 
  #   La etiqueta puede contener más texto alrededor de _valor_.
  #
  #   El _selector_ de la etiqueta de puede poner o no entre comillas pero
  # éstas son obligatorias para _valor_
  #
  # Ejemplos:
  #  
  #     Entonces debo ver la etiqueta H1
  #     Entonces no debo ver la etiqueta div#title con el valor "Tomate"
  #     Entonces no debo ver la etiqueta 'div#title' con el valor "Tomate"
  #
  ########################################################################
    Cuando visito la portada
    Entonces debo ver la etiqueta H1
    Entonces debo ver la etiqueta "H1"
    Entonces no debo ver la etiqueta HR
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
    Entonces debo ver la etiqueta H1 con el valor "app.welcome.title"
    Entonces no debo ver la etiqueta H1 con el valor "PORTADA DE MUNDO PEPINO"
    Entonces debo ver la etiqueta DIV#slogan con el valor "Todo un huerto para ti"
    Entonces debo ver la etiqueta 'div#slogan' con el valor "Todo un huerto para ti"
    Entonces no debo ver la etiqueta DIV#title con el valor "Todo un huerto para ti"
    Entonces no debo ver la etiqueta DIV#title con el texto "Todo un huerto para ti"
