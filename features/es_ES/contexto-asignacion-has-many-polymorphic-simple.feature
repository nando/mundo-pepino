Característica: asignación simple de instancias en campo has_many polimórfico

  Escenario: Asignación simple de un campo has_many polimórfico
  ########################################################################
  # Patrón: 
  #   Dado que dicho/a _padre_ tiene _numero_ _hijos_( (llamados) "_nombres_")?
  #
  # Ejemplos:
  #   Dado que dicho huerto tiene dos aspersores "Aereo y Emergente"
  #   Dado que dicho bancal tiene 20 aspersores
  #
  # Descripción:
  #     Crea _numero_ instancias del modelo  _hijos_ y las asocia al 
  #   último recurso mendionado cuyo modelo sea  _padre_
  # 
  #   Opcionalmente pueden facilitarse el/los nombre/s de las instancias.
  #   Si se facilitan _numero_ de nombres en _nombres_ (separándolos con 
  #   "," e "Y") a cada hijo le asignará su nombre correspondiente. En 
  #   caso contrario asignará a todos los hijos como nombre la cadena 
  #   completa.
  #
  ########################################################################
    Dado que tenemos un huerto "H-01"
       Y que dicho huerto tiene dos aspersores "Aereo y Emergente"
       Y que tenemos un huerto "H-04"
       Y que dicho huerto tiene 10 aspersores
    Entonces tenemos en bbdd dos huertos
           Y 12 aspersores
           Y el huerto "H-01" tiene en bbdd un aspersor "Aereo"
           Y el huerto "H-01" tiene en bbdd un aspersor "Emergente"

