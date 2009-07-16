Característica: etiqueta/selector con valor

  Escenario: Veo (o no) una etiqueta HTML opcionalmente con un contenido concreto 
  ########################################################################
  # Patrón: 
  #   Entonces (no) debo ver la etiqueta _selector_( con el texto "_valor_")
  # o:
  #   Entonces (no) debo ver en la etiqueta _selector_( el texto "_valor_")
  # o:
  #   Entonces (no) veo la etiqueta _selector_( con el texto "_valor_")
  # o:
  #   Entonces (no) veo el selector _selector_( con el texto "_valor_")
  # o:
  #   Entonces (no) veo el tag _selector_( con el texto "_valor_")
  #
  # Descripción:
  #   Comprueba la existencia o inexistencia de una etiqueta/selector que
  # opcionalmente debe tener un contenido concreto.
  # 
  #   Si facilitamos un _valor_ este deberá ir entre comillas y será buscado
  # sin distinguir mayúsculas y minúsculas (case insentive) y el selector/tag
  # podrá contener más texto alrededor de dicho _valor_.
  #
  #   El _selector_ se puede poner o no entre comillas pero son necesarias 
  # si queremos utilizar espacios para expresar jerarquía. 
  #
  # Ejemplos:
  #  
  #     Entonces debo ver la etiqueta H1
  #     Entonces no debo ver el selector div#title con el valor "Tomate"
  #     Entonces no debo ver el selector div#title con el texto "Tomate"
  #     Entonces no debo ver la etiqueta 'div#title a' con el valor "Tomate"
  #
  ########################################################################
    Cuando visito la portada
    Entonces debo ver el tag H1
    Entonces debo ver la etiqueta "H1"
    Entonces no debo ver el selector HR
    Entonces debo ver la etiqueta H1 con el valor "Portada de Mundo Pepino"
    Entonces debo ver la etiqueta H1 con el valor "MUNDO"
    Entonces debo ver la etiqueta H1 con el valor "app.welcome.title"
    Entonces debo ver la etiqueta DIV#slogan con el valor "Todo un huerto para ti"
    Entonces debo ver la etiqueta 'div#slogan' con el valor "Todo un huerto para ti"
    Entonces no debo ver la etiqueta DIV#title con el valor "Todo un huerto para ti"
    Entonces no debo ver la etiqueta DIV#title con el texto "Todo un huerto para ti"
    Entonces debo ver el selector "div label[for=login]"
    Entonces debo ver el selector "div label[for=login]" con el valor "Nombre de usuario"
