Característica: asignación en campo has_many :through desde fit table

  Escenario: Asignación en un solo padre
  ########################################################################
  # Patrón: 
  #   Dado que dicho/a _mod_padre_ tiene el/la/los/las siguiente/s _mod_hijo_:
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
  #   Dado que dicho huerto tiene los siguientes cultivos:
  #     |nombre |estación        |
  #     |Tomates|verano          |
  #     |Pepinos|primavera-verano|
  #     |Patatas|invierno        |
  #
  ########################################################################
    Dado que tenemos un huerto llamado "H-01"
    Dado que dicho huerto tiene los siguientes cultivos:
      |nombre |estación        |
      |Tomates|verano          |
      |Pepinos|primavera-verano|
      |Patatas|invierno        |
    Entonces tenemos en bbdd un huerto
           Y tenemos en bbdd tres bancales
           Y tenemos en bbdd tres cultivos
           Y el huerto "H-01" tiene en bbdd un cultivo "Patatas"
           Y tiene en bbdd un cultivo "Pepinos"
           Y tiene en bbdd un cultivo "Tomates"
           
  Escenario: Asignación en varios padres
    Dado que tenemos dos huerto llamado "A y B"
    Dado que dichos huertos tienen los siguientes cultivos:
      |nombre |estación        |
      |Tomates|verano          |
      |Pepinos|primavera-verano|
      |Patatas|invierno        |
    Entonces tenemos en bbdd 2 huerto
           Y tenemos en bbdd 6 bancales
           Y tenemos en bbdd 3 cultivos
           Y el huerto "A" tiene en bbdd un cultivo "Patatas"
           Y tiene en bbdd un cultivo "Pepinos"
           Y tiene en bbdd un cultivo "Tomates"
           Y el huerto "B" tiene en bbdd un cultivo "Patatas"
           Y tiene en bbdd un cultivo "Pepinos"
           Y tiene en bbdd un cultivo "Tomates"

