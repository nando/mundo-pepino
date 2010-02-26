# language: es
Característica: Tenemos en BBDD uno o más registros de un modelo

  Escenario: Tenemos en BBDD uno o más registros de un modelo opcionalmente con un nombre concreto
  ########################################################################
  # Patrón:
  #   Entonces tenemos en (la)? base de datos _numero_ _modelo_ ((llamado)? "_nombre_")?
  # o:
  #   Entonces en (la)? base de datos tenemos _numero_ _modelo_ ((llamado)? "_nombre_")?
  # o:
  #   Entonces tenemos en (la)? bbdd _numero_ _modelo_ ((llamado)? "_nombre_")?
  # o:
  #   Entonces en (la)? bbdd tenemos _numero_ _modelo_ ((llamado)? "_nombre_")?
  #
  # Ejemplos:
  #   Entonces tenemos en la base de datos 24 Acelgas
  #   Entonces tenemos en la base de datos un Abono llamado "FSF-03"
  #
  # Descripción:
  #   Comprueba que tenemos en base de datos _numero_ de registro/s en la 
  # la tabla correspondiente a _modelo_, opcionalmente con un _nombre_
  # concreto
  #
  ########################################################################
    Dado que tenemos los siguientes huertos:
           | nombre  | área | latitud  | latitud   | abono   |
           | Secano  | 35   | N 40° 44 | W 003° 48 | FSF-315 |
           | Regadío | 31   | N 41º 26 | W 003° 42 | FSF-311 |
       Y que el huerto "Secano" tiene un bancal "Largo"
       Y que el bancal "Largo" tiene 5 pepinos
    Entonces tenemos en base de datos dos huertos
           Y tenemos en la base de datos dos huertos 
           Y en la base de datos tenemos dos huertos
           Y en base de datos tenemos dos huertos
           Y tenemos en bbdd dos huertos
           Y tenemos en la bbdd dos huertos 
           Y en la bbdd tenemos dos huertos
           Y en bbdd tenemos dos huertos
           Y tenemos en base de datos un huerto "Secano"
           Y tenemos en la base de datos un huerto "Secano" 
           Y en la base de datos tenemos un huerto "Secano"
           Y en base de datos tenemos un huerto "Secano"
           Y tenemos en bbdd un huerto "Secano"
           Y tenemos en la bbdd un huerto "Secano" 
           Y en la bbdd tenemos un huerto "Secano"
           Y en bbdd tenemos un huerto "Secano"
           Y tenemos en base de datos un huerto llamado "Regadío"
           Y el bancal "Largo" tiene en bbdd cinco pepinos

  Escenario: dos campos has_many del mismo modelo
  # Un usuario tiene "flores enviadas" y "flores" (recibidas).
    Dado que tenemos los siguientes usuarios:
      | nombre    |
      | Rosa      |
      | Antonio   |
      | Jacinto   |
      | Tomás     |
    Y que inicio sesión con la usuaria Rosa
    Cuando que visito la página de nueva Flor
         Y relleno título con "hortensia"
         Y marco "Jacinto"
         Y marco "Tomás"
         Y pulso el botón "Enviar"
    Entonces debería ver el texto "Flor enviada"
           Y tenemos en la bbdd dos envíos
           Y la usuaria "Rosa" tiene en bbdd una flor enviada
           Y el usuario "Jacinto" tiene en bbdd una flor
           Y el usuario "Tomás" tiene en bbdd una flor
           Y el usuario "Antonio" tiene en bbdd 0 flores
           Y la flor "hortensia" tiene en bbdd dos usuarios
           Y la flor "hortensia" tiene en bbdd como remitente "Rosa"
