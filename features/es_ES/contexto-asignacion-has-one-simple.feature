Característica: asignación simple de instancias en campo has_one

  Escenario: Asignación simple de un campo has_one
  ########################################################################
  # Patrón: 
  #   Dado que dicho/a _padre_ tiene _uno_ _hijo_( (llamado) "_nombre_")?
  #
  # Ejemplos:
  #   Dado que dicho usuario tiene un perfil "Jacinto"
  #   Dado que dicho bancal tiene 1 perfil
  #
  # Descripción:
  #     Crea _uno_ instancia del modelo  _hijo_ y las asocia al
  #   último recurso mendionado cuyo modelo sea  _padre_
  # 
  #   Opcionalmente pueden facilitarse el nombre de la instancia.
  #
  ########################################################################
    Dado que tenemos un usuario "jacinto"
       Y que dicho usuario tiene un perfil "Jacinto"
       Y que tenemos una usuaria "tomasa"
       Y que dicha usuaria tiene 1 perfil "Tomasa"
    Entonces tenemos en bbdd 2 perfiles
       Y el usuario "jacinto" tiene en bbdd un perfil "Jacinto"
       Y la usuaria "tomasa" tiene en bbdd un perfil "Tomasa"