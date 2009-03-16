Característica: asignación en campo has_many :through desde fit table

  Escenario: Asignación en campo has_many :through desde fit table
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

