Característica: implementación de pasos habituales
  Para escribir sólo la definición de los pasos específicos de mi proyecto
  Como usuario de Cucumber
  Quiero tener definidos e implementados los pasos más habituales

  Escenario: huerto con tres bancales
    Dado que tenemos un huerto llamado "Hortalizas"
       Y que dicho huerto tiene tres bancales "Acelgas, Tomates y Pepinos"
       Y que dichos bancales tienen como longitud "2" metros
       Y que el bancal "Acelgas" tiene como matas "7"
       Y que dicho bancal tiene las siguientes acelgas:
         | nombre | peso | longitud |
         |      A |   30 |      115 |
         |      B |   23 |       35 |
         |      C |   41 |      135 |
         |      D |   91 |      215 |
         |      E |   65 |      145 |
         |      F |   83 |      195 |
         |      G |   49 |      155 |
       Y que dichas acelgas tienen como variedad "Gigante carmesí"
       Y que el bancal "Tomates" tiene como matas "2"
       Y que dicho bancal tiene cuatro tomates "A, B, C y D"
       Y que el tomate "A" tiene como variedad "Raf"
       Y que dicho tomate tiene como diámetro "97" milímetros
       Y que el tomate "B" tiene como variedad "Ramo"
       Y que dicho tomate tiene como diámetro "43" milímetros
       Y que el bancal "Pepinos" tiene los siguientes pepinos:
         | nombre | peso | longitud | diámetro |
         |     P1 |   30 |      115 |       23 |
         |     P2 |   23 |       35 |       12 |
         |     P3 |   41 |      135 |       18 |
       Y que el Pepino "P1" tiene como diámetro "12" milímetros
    Entonces tenemos en bbdd un huerto llamado "Hortalizas"
           Y tenemos en bbdd 7 acelgas
           Y tenemos en bbdd 4 tomates
           Y tenemos en bbdd 3 pepinos
           Y el huerto "Hortalizas" tiene en bbdd un bancal "Acelgas"
           Y el bancal "Acelgas" tiene en bbdd siete acelgas
           Y tiene en bbdd una acelga "A"
           Y tiene en bbdd una acelga "F"
           Y la acelga "F" tiene en bbdd como peso "83" gramos
           Y tiene en bbdd como variedad "Gigante carmesí"
           Y el bancal "Tomates" tiene en bbdd un tomate "A"
           Y tiene en bbdd cuatro tomates
           Y el tomate "A" tiene en bbdd como variedad "Raf"
           Y el tomate "A" tiene en bbdd como diámetro "97" milímetros
           Y el bancal "Pepinos" tiene en bbdd tres pepinos
           Y el bancal "Pepinos" tiene en bbdd un pepino "P1"
           Y tiene en bbdd un pepino "P2"
           Y tiene en bbdd un pepino "P3"
           Y el pepino "P1" tiene en bbdd como diámetro "12" milímetros
           Y tiene en bbdd como peso "30" gramos
