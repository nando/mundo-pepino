Característica: asignación simple de instancias en campo has_many 

  Escenario: Asignación simple de un campo has_many
  ########################################################################
  # Patrón: 
  #   Dado que dicho/a _padre_ tiene _numero_ _hijos_( (llamados) "_nombres_")?
  #
  # Ejemplos:
  #   Dado que dicho huerto tiene tres bancales "Acelgas, Tomates y Pepinos"
  #   Dado que dicho bancal tiene 20 acelgas
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
       Y que dicho huerto tiene tres bancales "Acelgas, Tomates y Pepinos"
       Y que tenemos un huerto "H-02"
       Y que dicho huerto tiene dos bancales llamados "Berzas y Patatas"
       Y que tenemos un huerto "H-03"
       Y que dicho huerto tiene un bancal llamado "Pitos y flautas"
       Y que tenemos un huerto "H-04"
       Y que dicho huerto tiene 10 bancales
    Entonces tenemos en bbdd cuatro huertos
           Y 16 bancales
           Y el huerto "H-01" tiene en bbdd un bancal "Acelgas"
           Y tiene en bbdd un bancal "Tomates"
           Y tiene en bbdd un bancal "Pepinos"
           Y el huerto "H-02" tiene en bbdd un bancal "Berzas"
           Y tiene en bbdd un bancal "Patatas"
           Y el huerto "H-03" tiene en bbdd un bancal "Pitos y flautas"
