Característica: asignación en campo has_many :through desde fit table en un recurso concreto

  Escenario: Asignación en campo has_many :through desde fit table en un recurso concreto
  ########################################################################
  # Patrón: 
  #   Dado que el/la _mod_padre_ "_nombre_del_padre_" tiene el/la/los/las siguiente/s _mod_hijo_:
  #     | campo1 | campo2 |  ...  | campoN |
  #     | v1-1   | v2-2   |  ...  | v2-N   |
  #         .        .       ...      .
  #         .        .       ...      .
  #         .        .       ...      .
  #     | vN-1   | vN-2   |  ...  | vN-N   |
  #
  # Ejemplo:
  #   Los huertos se dividen en bancales y estos últimos tienen un cultivo
  # asociado. Los huertos tienen cultivos a través de sus bancales y podemos
  # escribir cosas como:
  #
  #   Dado que el huerto "H-01" tiene los siguientes cultivos:
  #     |nombre |estación        |
  #     |Tomates|verano          |
  #     |Pepinos|primavera-verano|
  #     |Patatas|invierno        |
  #
  ########################################################################
    Dado que tenemos dos huertos llamados "H-01 y H-02"
       Y que el huerto "H-01" tiene los siguientes cultivos:
           |nombre |estación        |
           |Tomates|verano          |
           |Pepinos|primavera-verano|
           |Patatas|invierno        |
       Y que el huerto "H-02" tiene los siguientes cultivos:
           |nombre |estación        |
           |Zanahorias|verano          |
           |Melones   |primavera-verano|
    Entonces tenemos en bbdd dos huerto
           Y tenemos en bbdd cinco bancales
           Y tenemos en bbdd cinco cultivos
           Y el huerto "H-01" tiene en bbdd un cultivo "Patatas"
           Y tiene en bbdd un cultivo "Pepinos"
           Y tiene en bbdd un cultivo "Tomates"
           Y el huerto "H-02" tiene en bbdd un cultivo "Zanahorias"
           Y tiene en bbdd un cultivo "Melones"
