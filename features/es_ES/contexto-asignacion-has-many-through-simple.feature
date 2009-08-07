Característica: asignación simple de instancias en campo has_many :through 

  Escenario: Asignación a un solo padre
  ########################################################################
  # Patrón: 
  #   Dado que dicho/a _padre_ tiene _numero_ _hijos_( (llamados) "_nombres_")?
  #
  # Ejemplo:
  #   Los huertos se dividen en bancales y estos últimos tienen un cultivo
  # asociado. Los huertos tienen cultivos a través de sus bancales y podemos
  # escribir cosas como:
  #
  #   Dado que dicho huerto tiene cuatro cultivos "A, B, C y D"
  #   Dado que dicho huerto tiene 20 cultivos
  #
  ########################################################################
    Dado que tenemos un huerto "H-01"
       Y que dicho huerto tiene 7 cultivos
       Y que tenemos un huerto "H-02"
       Y que dicho huerto tiene tres cultivos "Patatas, Pepinos y Zanahorias"
    Entonces tenemos en bbdd dos huertos
           Y 10 bancales
           Y 10 cultivos
           Y el huerto "H-02" tiene en bbdd un cultivo "Patatas"
           Y tiene en bbdd un cultivo "Pepinos"
           Y tiene en bbdd un cultivo "Zanahorias"

  Escenario: Asignación a un grupo de padres
    Dado que tenemos tres huertos
       Y que dichos huertos tienen 7 cultivos
       Y que tenemos dos huertos "A y B"
       Y que dichos huertos tienen tres cultivos "Patatas, Pepinos y Zanahorias"
    Entonces tenemos en bbdd 5 huertos
           Y 36 bancales
           Y 10 cultivos
           Y el huerto "A" tiene en bbdd un cultivo "Patatas"
           Y tiene en bbdd un cultivo "Pepinos"
           Y tiene en bbdd un cultivo "Zanahorias"
           Y el huerto "B" tiene en bbdd un cultivo "Patatas"
           Y tiene en bbdd un cultivo "Pepinos"
           Y tiene en bbdd un cultivo "Zanahorias"

