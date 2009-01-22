Característica: Veo un formulario con determinados campos
  Escenario: Veo un formulario con determinados campos convenientemente etiquetados
  # Patrón:
  #   Entonces debería ver un formulario con el/los siguente/s campo/s:
  # o:
  #   Entonces debo ver un formulario con el/los siguente/s campo/s:
  # o:
  #   Entonces veo un formulario con el/los siguente/s campo/s:
  #     | ETIQUETA | CAMPO |
  #     | e1-1     | c2-2  |
  #         .          .   |
  #     | eN-1     | cN-2  |
  #
  # Ejemplo:
  #   Entonces veo una tabla con el contenido:
  #     | nombre    | área | longitud | latitud   |
  #     | Regadío-1 | 15   | N 41° 35 | W 003° 48 |
  #     | Regadío-2 | 42   | N 41° 35 | W 003° 48 |
    Cuando visito la portada
    Entonces veo un formulario con los siguientes campos:
        | Etiqueta              | Campo     |
        | Nombre de usuario     | textfield |
        | Contraseña            | password  |
        | Galleta de la Fortuna | submit    |

  Escenario: Idem pero con otros nombres en la cabecera
    Cuando visito la portada
    Entonces veo un formulario con el campo:
        | Letrero               | Tipo      |
        | Nombre de usuario     | textfield |
        | Contraseña            | password  |
        | Galleta de la Fortuna | submit    |
