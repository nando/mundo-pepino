Característica: Borro el enésimo recurso desde su índice (**)

  Escenario: Borro el enésimo recurso desde la página de su índice (index)
  ########################################################################
  # Patrón: 
  #   Cuando borro el/la _modelo_ en la _posicion_ posición
  #
  # Descripción:
  #   Desde un índice de recursos borro el enésimo pinchando en su enlace
  # de "Borrar".
  # 
  # **: paso (de dudosa utilidad) generado por 'script/generate feature'
  #  e implementado para que su característica auto-generada equivalente 
  #  tenga cobertura.
  #
  # Ejemplo:
  #   Cuando borro el Artículo en 7ª posición
  #
  ########################################################################
    Dado que tenemos las siguientes huertas:
           | nombre    | área | longitud | latitud   |
           | Regadío-1 | 15   | N 41° 35 | W 003° 48 |
           | Regadío-2 | 42   | N 42° 31 | W 003° 48 |
           | Regadío-3 | 2    | N 43° 35 | W 003° 48 |
           | Regadío-4 | 34   | N 44° 37 | W 003° 48 |
           | Regadío-5 | 81   | N 45° 34 | W 003° 48 |
           | Regadío-6 | 12   | N 46° 15 | W 003° 48 |
    Cuando borro el huerto en 6ª posición
    Entonces tenemos en la base de datos 0 huertos llamados "Regadío-6"
    Cuando borro el huerto en tercera posición
    Entonces tenemos en la base de datos 0 huertos llamados "Regadío-3"
    Cuando borro el huerto en segunda posición
    Entonces tenemos en la base de datos 0 huertos llamados "Regadío-2"
    Cuando borro el huerto en primera posición
    Entonces tenemos en la base de datos 0 huertos llamados "Regadío-1"
           Y tenemos en la base de datos un huerto llamado "Regadío-5"

