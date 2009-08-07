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
