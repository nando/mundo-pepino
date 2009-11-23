Característica: relleno el campo de un atributo anidado
  Antecedentes:
    Dado que visito la pagina de creación de huerto
       Y que relleno Nombre con "Huerto número 1"
      
  Escenario: Relleno campo de atributo anidado (*text* o *textarea*)  
  ########################################################################
  # Patrón atributo de nuevo recurso anidado: 
  # 
  #   Cuando relleno/completo el? _campo_ del su nuevo _modelo_ con (el valor)? "_valor_"
  #
  # Patrón edición de atributo de recurso anidado existente: 
  # 
  #   Cuando relleno/completo el? _campo_ del _modelo_anidado_ _nombre_ con (el valor)? "_valor_"
  #
  ########################################################################
    Dado que relleno el Nombre de su nuevo bancal con "Primel Vancal" 
       Y que pulso el botón "Crear"
    Entonces veo el tag 'div#terraces ul li' con el valor "Primel Vancal"
  # Y digo "uuuh... fatal!"

    Dado que pulso en el enlace "Editar"
    Cuando relleno el Nombre del bancal "Primel Vancal" con "Primer bancal"
         Y pulso en el botón "Guardar"
    Entonces veo el tag 'div#terraces ul li' con el valor "Primer bancal"
  # Y digo "eeeh... genial!"

    Dado que pulso en el enlace "Editar"
       Y que relleno el Nombre de su nuevo bancal con "Segundo bancal" 
       Y que pulso el botón "Guardar"
    Entonces veo el tag 'div#terraces ul li' con el valor "Segundo bancal"
           Y veo el tag 'div#terraces ul li' con el valor "Primer bancal"
