Característica: Veo un formulario con determinados campos
  Escenario: Veo un formulario con determinados campos convenientemente etiquetados
  # Patrón:
  #   Entonces debería ver un formulario con el/los (siguente/s)? campo/s:
  # o:
  #   Entonces debo ver un formulario con el/los (siguente/s)? campo/s:
  # o:
  #   Entonces veo un formulario con el/los (siguente/s)? campo/s:
  #     | ETIQUETA | CAMPO |
  #     | e1-1     | c2-2  |
  #         .          .   |
  #     | eN-1     | cN-2  |
  #
  # Descripción:
  #   Comprueba la existencia de un formulario con determinados campos
  # que hallan sido etiquetados con <labels>. Para ello recibe como 
  # parámetro una tabla con las siguientes columnas:
  # 
  #   - La primera columna con los nombres de las etiquetas de los 
  # campos, excepto para campos de tipo "submit" en cuyo caso se 
  # indicará el valor deseado para su atributo "value" (*).
  #  
  #   - La segunda con el tipo de campo: textfield, textarea, radio, 
  # checkbox, select, file, password o submit.
  #
  #   Los nombres utilizados en la cabecera son ignorados (lo importante 
  # es el orden de las columnas). 
  #
  # Ejemplos:
  #   Tanto para un formulario en el cual definimos:
  #
  #     <%= label_tag :password, "Contraseña" %>
  #     <%= password_field_tag :password %>
  #   
  #   como para un formulario generado con <% form_for instance do |f| %>
  #
  #     <%= f.label :password, "Contraseña" %>
  #     <%= f.password_field :password %>
  #
  #   Podríamos especificar:
  #     Entonces veo un formulario con el campo:
  #       | Contraseña | password  |
  #
  # (*) Para los campos de tipo "radio" actualmente no es posible 
  #     comprobar una asociación directa con su "etiqueta" (ya que
  #     la <label> realmente hace referencia a varios <input>). 
  #     Por este la comprobación se realiza asumiendo que existe un
  #     elemento <div> dentro del cual están la etiqueta y los 
  #     botones radio. Por ejemplo:
  #
  #       <div>
  #         <%= label_tag :color, "Color" %>
  #         <%= radio_button_tag :color, "verde" %>
  #         <%= radio_button_tag :color, "rojo" %>
  #         <%= radio_button_tag :color, "gris" %>
  #       </div>
  # 
  #################################################################

    Cuando visito la portada
    Entonces veo un formulario con los siguientes campos:
        | Etiqueta              | Campo    |
        | Nombre de usuario     | text     |
        | Contraseña            | password |
        | Biografía             | textarea |
        | Color                 | radio    |
        | Seleccionado          | checkbox |
        | Tipo de cultivo       | select   |
        | Avatar                | file     |
        | Galleta de la Fortuna | submit   |

  Escenario: Idem pero con otros nombres en la cabecera
    Cuando visito la portada
    Entonces veo un formulario con el campo:
        | Letrero               | Tipo      |
        | Nombre de usuario     | text      |
        | Contraseña            | password  |
        | Galleta de la Fortuna | submit    |
