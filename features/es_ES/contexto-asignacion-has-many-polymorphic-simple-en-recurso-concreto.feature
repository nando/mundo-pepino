Característica: asignación simple de instancias en campo has_many polimórfico en recurso concreto

  Escenario: Asignación simple de un campo has_many polimórfico en un recurso concreto
  ########################################################################
  # Patrón: 
  #   Dado que el/la _modelo_padre_ "_nombre_del_padre_" tiene _numero_ _hijos_( (llamados) "_nombres_")?
  #
  # Ejemplos:
  #   Dado que la huerta "H-01" tiene dos aspersores "Aereo y Emergente"
  #
  # Descripción:
  #     Crea _numero_ instancias del modelo  _hijos_ y las asocia al 
  #   recurso _modelo_padre_ cuyo nombre sea _nombre_del_padre_.
  # 
  #   Opcionalmente pueden facilitarse el/los nombre/s de las instancias.
  #   Si se facilitan _numero_ de nombres en _nombres_ (separándolos con 
  #   "," e "Y") a cada hijo le asignará su nombre correspondiente. En 
  #   caso contrario asignará a todos los hijos como nombre la cadena 
  #   completa.
  #
  ########################################################################
    Dado que tenemos dos huertos "H-01 y H-02"
       Y que el huerto "H-01" tiene dos aspersores "Aereo y Emergente"
       Y que el huerto "H-02" tiene 10 aspersores
    Entonces tenemos en bbdd dos huertos
           Y 12 aspersores
           Y el huerto "H-01" tiene en bbdd un aspersor "Aereo"
           Y el huerto "H-01" tiene en bbdd un aspersor "Emergente"

