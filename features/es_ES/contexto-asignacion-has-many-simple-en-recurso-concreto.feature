Característica: asignación simple de instancias en campo has_many en un recurso concreto 

  Escenario: Asignación simple de un campo has_many en un recurso concreto
  ########################################################################
  # Patrón: 
  #   Dado que el/la _padre_ _nombre_del_padre_ tiene _numero_ _hijos_( (llamados) "_nombres_")?
  #
  # Ejemplos:
  #   Dado que la huerta "B2" tiene tres bancales "Acelgas, Tomates y Pepinos"
  #   Dado que el bancal "Acelgas Verdes" tiene 20 acelgas
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
    Dado que tenemos cuatro huertos "H-01, H-02, H-03 y H-04"
       Y que la huerta "H-01" tiene tres bancales "Acelgas, Tomates y Pepinos"
       Y que el huerto "H-02" tiene dos bancales llamados "Berzas y Patatas"
       Y que el huerto "H-03" tiene un bancal llamado "Pitos y flautas"
       Y que el huerto "H-04" tiene 10 bancales
    Cuando visito su página
    Entonces debo ver la etiqueta H2 con el valor "H-04"
           Y tenemos en bbdd cuatro huertos
           Y 16 bancales
           Y el huerto "H-01" tiene en bbdd un bancal "Acelgas"
           Y tiene en bbdd un bancal "Tomates"
           Y tiene en bbdd un bancal "Pepinos"
           Y el huerto "H-02" tiene en bbdd un bancal "Berzas"
           Y tiene en bbdd un bancal "Patatas"
           Y el huerto "H-03" tiene en bbdd un bancal "Pitos y flautas"
