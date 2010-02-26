# language: es
Característica: asignación simple de instancias en campo has_many :through en un recurso concreto

  Escenario: Asignación simple de instancias en campo has_many :through en un recurso concreto
  ########################################################################
  # Patrón: 
  #   Dado que el/la _modelo_padre_ "_nombre_del_padre_" tiene _numero_ _hijos_( (llamados) "_nombres_")?
  #
  # Ejemplo:
  #   Los huertos se dividen en bancales y estos últimos tienen un cultivo
  # asociado. Los huertos tienen cultivos a través de sus bancales y podemos
  # escribir cosas como:
  #
  #   Dado que el huerto "H-01" tiene cuatro cultivos "A, B, C y D"
  #   Dado que la huerta "H-02" tiene 20 cultivos
  #
  ########################################################################
    Dado que tenemos dos huertos "H-01 y H-02"
       Y que el huerto "H-01" tiene 7 cultivos
       Y que la huerta "H-02" tiene tres cultivos "Patatas, Pepinos y Zanahorias"
    Entonces tenemos en bbdd dos huertos
           Y 10 bancales
           Y 10 cultivos
           Y el huerto "H-02" tiene en bbdd un cultivo "Patatas"
           Y tiene en bbdd un cultivo "Pepinos"
           Y tiene en bbdd un cultivo "Zanahorias"
