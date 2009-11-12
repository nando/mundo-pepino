Característica: relleno el campo de un atributo anidado

  Escenario: Relleno campo de atributo anidado (*text* o *textarea*)  
  ########################################################################
  # Patrón: 
  #   Cuando relleno/completo el? _campo_ del _modelo_anidado_ _nombre_ con (el valor)? "_valor_"
  #
  ########################################################################
    Dado que visito la pagina de creación de huerto
       Y que relleno Nombre con "Huerto número 1"
       Y que relleno "Nuevo bancal" con "Primer bancal" 
       Y que pulso el botón "Crear"
       Y que pulso en el enlace "Editar"
    Cuando relleno el nombre del bancal "Primer bancal" con "Bancal número 1"
         Y pulso en el botón "Guardar"
    Entonces veo el tag 'div#terraces ul li' con el valor "Bancal número 1"

