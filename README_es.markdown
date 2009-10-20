# MundoPepino

¡Bienvenidas y bienvenidos al MundoPepino!

MundoPepino es un conjunto de pasos genéricos para testear una aplicación Rails utilizando Cucumber.

## ¿Por qué un MundoPepino?

Expresar el comportamiento de una aplicación utilizando lenguaje natural tiene que lidiar con el hecho de que una misma frase puede ser expresada de muchas formas diferentes. Este hecho puede conducirnos fácilmente hacia una explosión de definiciones que dificulte su mantenimiento y, por ende, el de la aplicación en la que son utilizadas.

Al mismo tiempo existen expresiones que son de uso frecuente cuando describimos una aplicación, sobre todo si para ello empleamos un estilo imperativo (como pueden ser por ejemplo las interacciones que realizamos desde un navegador). MundoPepino es un intento de definir e implementar dichas expresiones comunes de tal forma que sólo nos preocupemos por aquellas que, por necesidad o conveniencia, consideremos específicas de la aplicación que estamos desarrollando.

Por otro lado, cuando el idioma utilizado no es inglés es necesario evitar las posibles ambigüedades que genera la traducción de nuestra aplicación. Para posibilitar un lenguaje ubicuo, MundoPepino fuerza la vinculación de las distintas partes de la aplicación (modelos, atributos, acciones y rutas) con los términos con los que nos referimos a las mismas desde nuestras características/features.

## Recursos

* **fuentes**: git://github.com/nando/mundo-pepino.git
* **cosillas**: [github issues](http://github.com/nando/mundo-pepino/issues)
* **lista**: [google group](http://groups.google.es/group/mundo-pepino)
* **ic**: [run-code-run](http://runcoderun.com/nando/mundo-pepino)
* **gema**: mundo-pepino

## Toma de contacto

    sudo gem install mundo-pepino
    rails mi_app; cd mi_app
    script/generate cucumber
    script/generate mundo_pepino
    script/generate caracteristica Orchard Huerto name:string:nombre area:integer:área longitude:string:longitud latitude:string:latitud used:boolean:usado
    script/generate scaffold Orchard name:string area:integer longitude:string latitude:string used:boolean
    rake db:migrate
    rake caracteristicas


En este punto deberíamos obtener dos errores, ambos debidos a que el *scaffold* genera las vistas en inglés y el generador de *caracteristica* los espera en castellano. El primero es el botón "Create" y el segundo el enlace "Destroy":

    $EDITOR app/views/orchards/index.html.erb # "Borrar" en lugar de "Destroy"
    $EDITOR app/views/orchards/new.html.erb # "Crear" en lugar de "Create"
    rake caracteristicas

Ahora sí, los escenarios deberían ser válidos, sin errores ni definiciones pendientes.

La intención del generador de características es más didáctica que pragmática. Ofrece un ejemplo simple que podemos toquetear para probar el plugin. Por otro lado se limita a hacer exactamente lo mismo que hace `generate feature` exceptuando el hecho de que no genera un fichero de **definiciones específicas** para la nueva *caracteristica* (ya que las utilizadas están comprendidas dentro de las **definiciones genéricas** ya implementadas en MundoPepino).

Dentro del plugin, en `features/support/app` está la aplicación que el MundoPepino utiliza para probarse a si mismo. En particular la característica `features/mundo-pepino.feature` pretente ser un compendio de escenarios que muestren las posibilidades que ofrece.

## Instalación

Como gema:

    gem install mundo-pepino

Como plugin (ver dependencias más abajo):

    script/plugin install git://github.com/nando/mundo-pepino.git

### Dependencias
  Si instalamos la gema junto con ella deberían quedar instaladas todas sus dependencias.

  Si instalamos mundo-pepino como plugin debemos tener instaladas las gemas o plugins de **cucumber**, **webrat**, **rspec** y **rspec-rails**. Por ejemplo, para instalar todas ellas como plugins:

    gem install term-ansicolor treetop diff-lcs nokogiri # dependencias de Cucumber
    script/plugin install git://github.com/aslakhellesoy/cucumber.git
    script/plugin install git://github.com/brynary/webrat.git
    script/plugin install git://github.com/dchelimsky/rspec.git
    script/plugin install git://github.com/dchelimsky/rspec-rails.git

  Además necesitamos instalar la gema o plugin StringMapper (ver más abajo):

    script/plugin install git://github.com/nando/string-mapper.git

  Si hacemos uso de alguno de los pasos que hacen referencia a la **selección de un mes** como parte de una fecha en un formulario necesitamos que el método ''strftime'' devuelva en nombre del mes en castellano cuando se utilice ''"%B"''. Para conseguirlo, tenemos entre otras las siguientes opciones (ver más abajo):

* instalar el módulo ruby-locale,
* o redefinir la función strftime para lograr dicho comportamiento.

#### [StringMapper](http://github.com/nando/string-mapper)

  StringMapper es una extensión de la clase String para obtener modelos, números, nombres de campo, etc. a partir de sus nombres en castellano.

    script/plugin install git://github.com/nando/string-mapper.git

#### [FixtureReplacement](http://replacefixtures.rubyforge.org/)

De fábrica MundoPepino utiliza ActiveRecord para incorporar a la BBDD los datos que soliciten los escenarios. 

Opcionalmente MundoPepino puede utilizar FixtureReplacement haciendo dicha tarea más simple y permitiéndo que los textos se centren en los objetivos de los escenarios sin preocuparse por el modelo de datos subyacente.

Para ello por un lado tenemos que instalar el plugin:

    script/plugin install http://thmadb.com/public_svn/plugins/fixture_replacement2/
    script/generate fixture_replacement

...y por otro, al final de `env.rb` (que el generador de cucumber deja dentro del directorio ''features/support'') tenemos que incluir FixtureReplacement como módulo de nuestro *mundo pepino* (más sobre esto en [A Whole New World](http://wiki.github.com/aslakhellesoy/cucumber/a-whole-new-world)):

    class MiMundo < MundoPepino
      include FixtureReplacement
    end
    
    World do
      MiMundo.new
    end 

#### [FactoryGirl](http://github.com/thoughtbot/factory_girl/)

Otra opción es utilizar FactoryGirl

Para ello por un lado tenemos que instalar la gema (para más información sobre FactoryGirl consultar (aquí)[http://github.com/thoughtbot/factory_girl/]):

    gem install thoughtbot-factory_girl --source http://gems.github.com

...y por otro, al final de `env.rb` (que el generador de cucumber deja dentro del directorio ''features/support'') tenemos que requerir la librería seguida de la definición de nuestras factorias:

    require 'factory_girl'
    require File.expand_path(File.dirname(__FILE__) + '/app/db/factories')

También se debe incluir un fichero donde se definan las factories a utilizar en nuestro mundo-pepino, como ejemplo consultar el fichero de factories que se encuentra en el directorio ''features/support/app/db/factories''

#### Selección de un mes en formularios

  Para los pasos que hacen referencia a la selección de un mes en una fecha la implementación actual (de Webrat) busca en nuestro HTML un mes cuyo nombre sea el devuelto por **strftime('%B')** en una instancia de Time creada a partir de la fecha facilitada. En Ruby, si no hacemos nada para remediarlo, esto es sinónimo del nombre del mes de dicha fecha en inglés.

  La opción más simple para resolver este problema es redefinir ''strftime'' para que devuelva el nombre del mes en el locale de la aplicación. Por ejemplo:

    class Time
      alias :strftime_nolocale :strftime
      def strftime(format)
        format = format.dup
        format.gsub!(/%B/, I18n.translate('date.month_names')[self.mon])
        self.strftime_nolocale(format)
      end
    end

  Otra opción sería instalar **ruby-locale**. **ruby-locale** es un (viejo) módulo que añade **soporte para locales en Ruby** al que se hace referencia [desde el wiki de Rails](http://wiki.rubyonrails.org/rails/pages/HowToOutputDatesInAnotherLanguage/). Instalándolo en el sistema tendremos la posibilidad de que strftime('%B') devuelva el nombre del mes en castellano.

  Para instalarlo nos bajamos [su código fuente](http://sourceforge.net/project/platformdownload.php?group_id=68254) y lo compilamos e instalamos en el sistema:

    ruby extconf.rb
    make
    sudo make install
    irb
    irb> require 'locale'
    => true
    irb> Time.now.strftime('%B')
    => "January"
    irb> Locale.setlocale(Locale::LC_TIME, "es_ES.UTF-8")
    => "es_ES"
    irb> Time.now.strftime('%B')
    => "enero" 

Por último, para que los helpers de Rails relacionados con la selección de fechas muestren los meses en castellano es necesario hacer uso de la opción **:use\_month\_names**, pasándole en la misma un array con los nombres de los doce meses que deseamos utilizar. Por ejemplo, en algún punto de nuestra aplicación definimos el array con los meses con:

    Meses = %w(enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre)

Y posteriormente en las vistas llamamos al helper con algo parecido a:

    <%= pepino.datetime_select :harvested_at, :use_month_names => Meses %>

## Uso

Para utilizar MundoPepino en una aplicación en la que todavía no estamos utilizando Cucumber lo más cómodo es comenzar utilizando los generadores (de forma similar a como se describe más arriba en *Toma de contacto*). Algo como:

    cd miapp-sin-cucumber
    script/plugin install git://github.com/nando/string-mapper.git
    script/plugin install git://github.com/nando/mundo-pepino.git
    script/generate mundo_pepino
    script/generate caracteristica Model Modelo name:string:nombre used:boolean:usado

Aquí ya deberíamos poder lanzar `rake caracteristicas`, obteniendo eso sí los errores pertinentes relacionados con implementación concreta de nuestro controlador. El fichero `gestion_de_modelo.feature` (que podemos renombrar por algo más chulo) nos servirá de patrón para escribir nuestra /característica/.

Para utilizar MundoPepino en una aplicación en la que ya estamos utilizando Cucumber, al final de `features/support/env.rb` (o equivalente) incorporamos lo siguiente:

    require 'mundo_pepino'
    String.model_mappings = {} # Mapeo castellano-inglés de modelos
    String.field_mappings = {} # Mapeo castellano-inglés de campos
    
    World do
      MundoPepino.new
    end

Es recomendable también vaciar el contenido de la BBDD antes de comenzar la evaluación de un nuevo escenario para que los datos que pueda haber de otros escenarios no alteren su resultado. La función *Before* nos puede ayudar para conseguirlo, haciendo algo como:

    Before do
      MiModelo.destroy_all
      MiOtroModelo.destroy_all # etc.
    end

*Before* se ejecutará antes de cada escenario y que los //Antecetentes// ((Background)[http://wiki.github.com/aslakhellesoy/cucumber/background]) de los mismos si los hubiese.

### generate mundo\_pepino

    rails_root$ script/generate mundo_pepino
          create  caracteristicas/support
          create  caracteristicas/support/mundo_pepino_env.rb
          exists  lib/tasks
          create  lib/tasks/mundo_pepino.rake

El principio de `mundo_pepino_env.rb` es el contenido del `env.rb` generado por `generate cucumber`, tras el cual añade lo siguiente:

    require 'mundo_pepino'          # Cargamos MundoPepino...
    MundoPepino::ModelsToClean = [] # Array con los modelos que serán limpiados 
                                    # antes de lanzar cada escenario.
    String.model_mappings = {}      # Hash con el mapeo de los modelos a partir
                                    # de sus equivalencias en castellano.
    String.field_mappings = {}      # Hash con el mapeo de los campos.
    class MiMundo < MundoPepino     # Ejemplo de uso del MundoPepio con herencia. 
      # include FixtureReplacement  # FR listo para entrar en acción. Meter aquí 
      # def mi_funcion; ...; end    # las funciones específicas que necesitemos
    end                             # desde nuestras definiciones.
    Before do                       # La limpieza de modelos propiamente dicha... 
      MundoPepino::ModelsToClean.each { |model| model.destroy_all }
    end                             # ...se realizará antes de cada escenario.  
    World do                        # Finalmente le pedimos a Cucumber que
      MiMundo.new                   # utilice una instancia de nuestro mundo como
    end                             # ámbito local de nuestros escenarios.

Por otro lado `mundo_pepino.rake` añade una tarea llamada **caracteristicas** que lanza con la opción `--language es` todos los ficheros con extensión `.feature` que tengamos dentro del directorio `caracteristicas`.

### generate caracteristica

Se trata del generador equivalente a `script/generate feature` de Cucumber:

    $ script/generate caracteristica Orchard Huerto name:string:nombre area:integer:área used:boolean:usado
    model_cleaning  added Orchard (Orchard.destroy_all call before each scenario)
    model_mapping   added /huertos?$/i => Orchard
    field_mapping   added /nombres?$/i => :name
    field_mapping   added /áreas?$/i => :area
    field_mapping   added /usados?$/i => :used
          create  caracteristicas/gestion_de_huertos.feature

El fichero `gestion_de_huertos.feature` tendría:

    Característica: Gestión de Huertos
      Para [beneficio]
      Como [sujeto]
      Quiero [característica/comportamiento]
    
      Escenario: Añadir un/a nuevo/a Huerto
        Dado que visito la página de nuevo/a Huerto
        Cuando relleno nombre con "nombre 0"
             Y relleno área con "0"
             Y relleno usado con "true"
             Y pulso el botón "Crear"
        Entonces debería ver el texto "nombre 0"
               Y debería ver el texto "0"
               Y debería ver el texto "true"
    
      Escenario: Borrar Huerto
        Dado que tenemos los/las siguientes Huertos:
          |nombre|área|usado|
          |nombre 1|1|false|
          |nombre 2|2|true|
          |nombre 3|3|false|
          |nombre 4|4|true|
        Cuando borro el/la Huerto en la tercera posición
        Entonces debería ver una tabla con los siguientes contenidos:
          |nombre|área|usado|
          |nombre 1|1|false|
          |nombre 2|2|true|
          |nombre 4|4|true|

A diferencia de `generate feature` aquí no se crea un fichero `step_definitions.rb` con definiciones e implementaciones específicas ya que las mismas se encuentran dentro de las tratadas genéricamente dentro del MundoPepino.

### Relación con modelo utilizando un nombre que no se corresponde con el mismo
Con un ejemplo se entiende mejor, creo. Tenemos un modelo User y un modelo Garden y este último "belongs_to :author, class_name => 'User'", de tal forma que //a_garden.author// nos devuelve un User.

Bien, pues para que la siguiente característica funcione correctamente:

    Dado que tenemos un usuario llamado "Fidel"
       Y que tenemos un jardín cuyo autor es "Fidel"

Tengo que meter los siguentes mapeos en nuestro entorno:
* En el mapeo de modelos (model_mappings):

    /^autor(es)?$/i => User

* En el mapeo de campos (field_mappings):

    /^autor(es)?$/i => :author

* Un mapeo adicional entre el nombre del campo en inglés y su modelo asociado (relation_model_mappings):

    'author' => User

Con estos mapeos también deberían funcionar el resto de definiciones de MP en las que se haga referencia a una relación.

## Definiciones implementadas en MundoPepino

**Cada definición** existente en MundoPepino tiene **al menos un escenario** que comprueba:
* por un lado que la expresión regular *machea* las posibles formas de expresarla,
* y por otro que la implementación lleva a cabo lo que se supone que debe hacer.

Para todos los escenarios podríamos tener una narrativa genérica que expresase algo como lo siguiente:

    Característica: implementación de pasos habituales
      Para escribir sólo la definición de los pasos específicos de mi proyecto
      Como usuario de Cucumber
      Quiero tener los pasos más habituales definidos, implementados y bien documentados

Sin embargo cada definición ha sido separada en un fichero `.feature` específico para poder enlazarlas desde este índice.


Como **convención general** los nombres correspondientes a modelos y campos pueden ir sin comillas pero los valores deben ir entre comillas (simples o dobles). Por ejemplo:

    Dado que tenemos un artículo que tiene como título "Título del artículo"

En el ejemplo, "artículo" y "título" hacen referencia a un modelo y a un campo respectivamente y no van entre comillas (aunque podrían ir si quisiéramos) mientras que "Título del artículo" es el valor que se asignará en "título" y como tal va entrecomillado (y si quitásemos sus comillas la expresión no sería reconocida o lo sería incorrectamente). 

MundoPepino soporta el uso de **claves I18n** en lugar de literales "a pincho" (o "hardcoded") en la mayoría de interacciones con el navegador (p.e. "Cuando pincho en el botón app.send" en lugar de "Cuando pincho en el botón 'Enviar'") así como en las comprobaciones de existencia de textos (p.e. "Debería ver el texto 'activerecord.models.user'" en lugar de "Debería ver el texto 'Usuario'").

Se puede utilizar la interpolación separando el hash con los parámetros de la clave con una coma sin espacios. Por ejemplo:

    Entonces debería ver la etiqueta H1 con el valor "app.users.new_friend,{:name => 'Lucas'}"


### Dado el contexto (Givens)

Convenciones generales:

* utilización de "que" para comenzar todas las definiciones para evitar falta de concordancia de género y número (p.e. "Dado **que** tenemos tres personas")
* creación de nuevos recursos utilizando verbo **tener** en tercena persona plural (p.e. "Dado que **tenemos** tres lechugas")
* asignación de valores con el verbo **tener** en tercera persona (p.e. "Dado que dichas Acelgas **tienen** como variedad Amarilla de Lyon")
* todas las definiciones para "Cuando algo ocurre" (o *Then's*, ver más abajo) son válidas también como "Dado el contexto" incorporándoles el prefijo "que" (p.e. "Dado que visito la portada").


#### Creación de uno o varios registros asignándoles opcionalmente un nombre
    Dado que tenemos Un Producto llamado "Acelgas" 
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/contexto-creacion-simple.feature)

#### Creación de uno o varios registros con un valor en un campo
    Dado que tenemos un huerto cuya área es de "1200" metros cuadrados
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/contexto-creacion-con-asignacion.feature)

#### Creación de uno o varios recursos a partir de una **step table**
    Dado que tenemos el siguiente Huerto:
           | nombre   | área | latitud  | latitud   | abono   |
           | Secano-1 | 35   | N 40° 44 | W 003° 48 | FSF-315 |
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/contexto-creacion-desde-step-table.feature)

#### Asignación de un valor en un campo de un recurso concreto
    Dado que el Tomate "A" tiene como variedad "Raf"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-de-valor-en-recurso.feature)

#### Asignación de un valor en un campo del último (o últimos) recurso mencionado
    Dado que dichas Acelgas tienen como Variedad "Gigante carmesí"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-de-valor-en-recurso-mencionado.feature)

#### Asignación simple a un campo **has\_many** de un recurso concreto
    Dado que el huerto "H-01" tiene dos bancales "Bancal de Acelgas y Bancal de Tomates"
[más ejemplos (has_many estándar)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-simple-en-recurso-concreto.feature) - 
[más ejemplos (has_many polimórfico)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-polymorphic-simple-en-recurso-concreto.feature) -
[más ejemplos (has_many through)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-through-simple-en-recurso-concreto.feature)

#### Asignación simple a un campo **has\_many** del último recurso mencionado
    Dado que dicho Huerto tiene Tres Bancales "Acelgas, Tomates y Pepinos"
[más ejemplos (has_many normal)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-simple.feature) - 
[más ejemplos (has_many polimórfico)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-polymorphic-simple.feature) -
[más ejemplos (has_many through)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-through-simple.feature)

#### Asignación en campo **has\_many** de un recurso concreto desde una step-table
    Dado que el huerto "H-01" tiene los siguientes bancales:
           | nombre | longitud | cultivo |  matas |
           |  A-01  |    12    | Patatas |     16 |
           |  A-02  |    12    | Tomates |     18 |
[más ejemplos (has_many normal)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-desde-fit-table-en-recurso-concreto.feature) - 
[más ejemplos (has_many polimórfico)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-polymorphic-desde-fit-table-en-recurso-concreto.feature) -
[más ejemplos (has_many through)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-through-desde-fit-table-en-recurso-concreto.feature)

#### Asignación en campo **has\_many** del último recurso mencionado desde una step-table
    Dado que dicho Huerto tiene los siguientes Bancales:
           | nombre | longitud | cultivo |  matas |
           |  A-01  |    12    | Patatas |     16 |
           |  A-02  |    12    | Tomates |     18 |
[más ejemplos (has_many normal)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-desde-fit-table.feature) - 
[más ejemplos (has_many polimórfico)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-polymorphic-desde-fit-table.feature) -
[más ejemplos (has_many through)](/nando/mundo-pepino/tree/master/features/es_ES/contexto-asignacion-has-many-through-desde-fit-table.feature)

### Cuando algo ocurre (Whens)

Convenciones generales:

* frases escritas en tiempo presente en primera persona del singular
* todas las definiciones son válidas también para definir contexto (en "Dados" o "Givens") incorporándoles el prefijo "que" (p.e. "Dado que visito la portada").

#### Solicitud de una URL específica opcionalmente indicada con un nombre coloquial
    Cuando visito la portada
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-visito-url-especifica.feature)
#### Solicitud de la URL asociada a un recurso concreto
    Cuando visito la página del huerto "H-01"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-visito-url-de-recurso-especifico.feature)
#### Solicitud de la URL asociada al último recurso definido
    Cuando visito su página
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-visito-url-de-recurso-mencionado.feature)
#### Solicitud de la URL del índice (index) de un tipo de recurso (modelo)
    Cuando visito la página de Tomates
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-visito-url-de-indice-de-tipo-de-recurso.feature)
#### Solicitud de la URL de creación de un recurso
    Cuando visito la página de creación de Tomate
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-visito-url-de-creacion.feature)
#### Solicitud de la URL de edición de un recurso
    Cuando visito la página de edición del huerto "H-01"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-visito-url-de-edicion.feature)
#### Pincho en un enlace \*
    Cuando pulso el enlace "Volver"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-pulso-el-enlace.feature)
#### Pincho/pulso un bóton (*submit*) \*
    Cuando pulso en el botón Enviar
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-pulso-el-boton.feature)
#### Adjunto un fichero (*file*) \*
    Cuando adjunto el fichero "images/cucumber.jpg" en Fotografía actual
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-adjunto-el-fichero.feature)
#### Elijo una opción (*radiobutton*) \*
    Cuando elijo el color "VERDE"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-elijo-de-radiobutton.feature)
#### Marco (o desmarco) una casilla (*checkbox*) \*
    Cuando marco "color verde"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-marco-el-checkbox.feature)
#### Relleno/completo un campo con un texto (*text* o *textarea*) \*
     Cuando completo 'nombre' con 'Wadus'
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-relleno-el-campo.feature)
#### Relleno/completo varios campos (*text* o *textarea*) desde una step-table \*
     Cuando completo:
       | Campo    | Valor    |
       | Nombre   | Lechuga  |
       | Color    | Verde    |
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-relleno-los-campos.feature)
#### Selecciono opción/opciones
##### Selecciono una opción de una lista (*select*) \*
     Cuando selecciono "Hortalizas" en el listado de "Tipos de cultivo"
##### Selecciono fecha y hora sin especificar en que campo \*
     Cuando selecciono 1 de septiembre de 1998, 12:46 como fecha y hora
##### Selecciono fecha y hora para un campo concreto \*
     Cuando selecciono 2 de mayo de 1998, 12:46 como fecha y hora de "Cosechado"
##### Selecciono una hora sin especificar en que campo \*
     Cuando selecciono 6:45PM como hora
##### Selecciono una hora para un campo concreto \*
     Cuando selecciono 2:45PM como hora del "café"
##### Selecciono fecha sin especificar en que campo \*
     Cuando selecciono 1 de septiembre de 1998 como fecha
##### Selecciono fecha para un campo concreto \*
     Cuando selecciono 2 de marzo de 2009 como fecha para el comienzo de la poda
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-selecciono-en-listado.feature)

#### Borro el enésimo recurso desde la página de su índice (index) \*\*
     Cuando borro el Bancal en 6ª posición
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/cuando-borro-el-enesimo-recurso.feature)

### Entonces pasa (Thens)

Convenciones generales:

* frases escritas en primera persona del singular (excepto comprobaciones en bbdd)
* para expresar que algo es visible utiliza "veo" o "debo ver" (o "no veo" y "no debo ver")
* las comprobaciones del contenido de la base de datos se escriben haciendo una referencia explícita a la misma en primera persona del plural ("tenemos en base de datos") o en tercera del singular ("tiene en base de datos"). Esta verbosidad es intencionada debido a que [dichas comprobaciones están desaconsejadas](http://github.com/aslakhellesoy/cucumber/wikis/given-when-then), haciendo así menos limpio y un poco más costoso su uso.

#### Veo (o no) un texto \*
    Entonces debo ver el texto "IVA incluido"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/veo-el-texto.feature)
#### Veo (o no) una serie de textos expresados en una step-table (sin cabeceras)
    Entonces debo ver los siguientes textos:
     | Muestras de tomate       |
     | Restos de lechuga        |
     | Treinta kilos de melones |
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/veo-los-siguientes-textos.feature)
#### Veo (o no) una etiqueta/selector opcionalmente con un contenido concreto
    Entonces no debo ver la etiqueta "div.title a" con el valor "Surco"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/veo-etiqueta-con-valor.feature)

#### Veo (o no) varios selectores opcionalmente determinados valores (step-table)
    Entonces debería ver los siguientes selectores:
             | Selector       | Valor                  |
             | h1             | Mundo Pepino           |
[más ejemplos]/mundo-pepino/tree/master/features/es_ES/veo-etiquetas-con-valores.feature
#### Leo (o no) un texto, quitando las etiquetas HTML
    Entonces debo leer el texto "IVA incluido"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/leo-el-texto.feature)
#### Leo (o no), quitando las etiquetas HTML, una serie de textos expresados en una step-table
    Entonces debo leer los siguientes textos:
     | Muestras de tomate       |
     | Restos de lechuga        |
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/leo-los-siguientes-textos.feature)
#### Veo (o no) un enlace a una URL específica (opcionalmente indicada con un nombre coloquial)
    Entonces debo ver un enlace a la página de recuperación de contraseña    
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/veo-enlace-a-url-especifica)
#### Veo (o no) un enlace a una URL relativa a una visitada con anterioridad
    Entonces debo ver un enlace a la siguiente página
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/veo-enlace-a-url-relativa)
#### Veo marcada (o desmarcada) una casilla (*checkbox*) \*
    Entonces veo marcado "Acepto las condiciones del servicio"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/veo-el-checkbox.feature)

#### Veo una tabla con determinados valores en sus celdas \*
    Entonces veo la tabla "bancales" con el siguiente contenido:
      | nombre | longitud | cultivo |  matas |
      |  A-01  |    12    | Patatas |     16 |
      |  A-02  |    12    | Tomates |     18 |
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/veo-una-tabla-con-determinado-contenido.feature)

#### Veo un formulario con determinados campos convenientemente etiquetados \*
    Entonces veo un formulario con los siguientes campos:
      | Etiqueta   | Tipo      |
      | Login      | textfield |
      | Contraseña | password  |
      | Entrar     | submit    |
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/veo-un-formulario-con-los-siguientes-campos.feature)


#### Tenemos en BBDD uno o más registros de un modelo opcionalmente con un nombre concreto
    Entonces tenemos en la base de datos un Abono llamado "FSF-03"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/tenemos-en-bbdd-registros.feature)

#### Tenemos en BBDD un valor en un campo de un registro concreto
    Entonces el Huerto "H-02" tiene en base de datos como Área "2" hectáreas
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/tenemos-en-bbdd-valor-en-campo-de-registro.feature)

#### Tenemos en BBDD un valor en un campo del registro mencionando anteriormente
    Entonces tiene en base de datos como Área "2" hectáreas
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/tenemos-en-bbdd-valor-en-campo-de-registro-mencionado.feature)

#### Tenemos en BBDD una asociación **has\_many** en un registro concreto
    Entonces el Huerto "H-02" tiene en base de datos un Bancal "A"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/tenemos-en-bbdd-asocioacion-has-many-en-registro.feature)

#### Tenemos en BBDD una asociación **has\_many**  en un registro mencionando anteriormente
    Entonces tiene en base de datos un Bancal "B"
[más ejemplos](/nando/mundo-pepino/tree/master/features/es_ES/tenemos-en-bbdd-asocioacion-has-many-en-registro-mencionado.feature)

(\*) Los **asteriscos** al final de la definición hacen referencia a las **definiciones oficialmente comunes** generadas en inglés por `script/generate cucumber`. Dos asteríscos (\*\*) hacen referencia a una definición presente en la feature autogenerada por `script/generate feature`.

## License

Copyright 2008, The Cocktail Experience. Fernando García Samblas <fernando.garcia at the-cocktail.com>

This is free software released under the GPL License (see license agreement in COPYING).
