Característica: Solicitud de URL de edición de un recurso

  Escenario: Solicitud de la URL asociada a la edición de un recurso
  ########################################################################
  # Patrón: 
  #   Cuando visito la página de edición del/de la _modelo_ "_nombre_"
  # o:
  #   Cuando visito la página de edición de "_nombre_"
  #
  # Descripción:
  #   Solicita la ruta correspondiente al formulario de edición de un 
  # recurso a partir del mapeo de su modelo en routes.rb
  #
  #   Si no encuentra dicho recurso lanza la excepción ResourceNotFound.
  # 
  #   En lugar de "edición" también están definidos como mapeos de acción
  # "edit" los "modificación" y "modificaciones".
  #
  # Ejemplos:
  #   Cuando visito la página de edición de la huerta "Regadío"
  #   Cuando visito la página de edición de "Regadío"
  #
  ########################################################################
    Dado que tenemos un huerto "Regadío"
    Cuando visito la página de edición del huerto "Regadío"
         Y selecciono 20:30 como hora de comienzo de riego
         Y pincho en el botón "Guardar"
    Entonces debería ver la etiqueta span#riego-comienzo con el valor "20:30"

    Cuando visito la página de modificación de la huerta "Regadío"
         Y selecciono 0:30 como hora de comienzo de riego
         Y pincho en el botón "Guardar"
    Entonces debería ver la etiqueta span#riego-comienzo con el valor "0:30"

    Cuando visito la página de modificaciones de "Regadío"
         Y selecciono 8:00 como hora de comienzo de riego
         Y pincho en el botón "Guardar"
    Entonces debería ver la etiqueta span#riego-comienzo con el valor "8:00"
