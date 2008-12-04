Característica: implementación de pasos genéricos
  Para escribir sólo la definición de los pasos específicos de mi proyecto
  Como usuario de Cucumber
  Quiero tener una serie de definiciones genéricas implementadas

  Escenario: Creación de uno (o varios) objetos con un nombre determinado
  # Patrón: Dado que hay _numero_ _modelo_( llamado _nombre_)
    Dado que hay un huerto
       Y que hay una huerta
       Y que hay un huerto "En el río"
       Y que hay una huerta "En el castro"
       Y que hay un huerto llamado "Regadío"
       Y que hay una huerta llamada "Secano"
       Y que hay 2 huertos
       Y que hay 2 huertos "Regadío"
       Y que hay 2 huertos llamados "Secano"
       Y que hay 2 huertas llamadas "Secano"
    Entonces existen 14 huertos
           Y existe un huerto "En el río"
           Y existe una huerta "En el castro"
           Y existen 3 huertos "Regadío"
           Y existen 5 huertas "Secano"
