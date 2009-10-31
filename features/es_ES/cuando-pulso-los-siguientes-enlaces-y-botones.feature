Característica: pulso una secuencia de enlaces y/o botones

  Escenario: Pincho/pulso una secuencia de enlaces
  ########################################################################
  # Patrón: 
  #   Cuando pincho/pulso (en)? los (siguientes)? enlaces:
  #     | enlace 1 |
  #         ...
  #     | enlace n |
  #
  ########################################################################
    Dado que visito la home
       Y que pulso en los siguientes enlaces:
         |Registro|
         |Volver  |
    Cuando pincho los siguientes enlaces:
           |Registro|
           |Volver  |
         Y pulso en los enlaces:
           |Registro|
           |Volver  |
         Y pincho los enlaces:
           |Registro|
           |Volver  |
           |Registro|
    Entonces veo la etiqueta H1 con el valor "Registro en Mundo Pepino"
