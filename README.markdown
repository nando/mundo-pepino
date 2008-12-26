# mundo-pepino

## What's in this world...

Expresing our app behaviour with a natural language has to deal with the fact that **one sentence can be expresed in many different ways**.

This fact can easily drive us towards an **explosion of the step definitions** making the maintenance of our app more difficult.

At the same time, to describe an app **there is a group of sentences that we're very likely to need**, like for example those which refer to posible interactions of the user while browsing a site.

Currently `script/generate cucumber` give to **English** cucumberists (or *cucus*, or *cucunuts*, or *cooks* ;) a proposal for some of those common steps in `step_definitions/webrat_steps.rb`.

mundo-pepino will be an already implemented set of step definitions frequently needed while writing a feature in **Spanish**, hopefully with all the `script/generate cucumber` proposals translated inside.

Bon appetit!

## Instalación

    $ script/plugin install git://github.com/nando/mundo-pepino.git

### Dependencias

  Además de las clásicas gemas o plugins de **cucumber**, **webrat**, **rspec** y **rspec-rails** es necesaria la instalación los siguientes plugins:

#### [FixtureReplacement](http://replacefixtures.rubyforge.org/)

    $ script/plugin install http://thmadb.com/public_svn/plugins/fixture_replacement2/
    $ script/generate fixture_replacement

#### [StringMapper](http://github.com/nando/string-mapper)

    $ script/plugin install git://github.com/nando/string-mapper.git

## Definiciones implementadas en MundoPepino

**Cada definición** existente en MundoPepino tiene **al menos un escenario** que comprueba:
* por un lado que la expresión regular *machea* las posibles formas de expresarla,
* y por otro que la implementación lleva a cabo lo que se supone que debe hacer.

Para todos los escenarios podríamos tener una narrativa genérica que expresase algo como lo siguiente:

    Característica: implementación de pasos habituales
      Para escribir sólo la definición de los pasos específicos de mi proyecto
      Como usuario de Cucumber
      Quiero tener los pasos más habituales definidos, implementados y bien documentados

Sin embargo cada definición ha sido separada en un fichero `.feature` específico para poder enlazarlas desde este índice. Los **asteriscos (\*)** al final de la definición hacen referencia a las **definiciones oficialmente comunes** generadas en inglés por `script/generate cucumber`.

### Dado el contexto (Givens)

Convenciones generales:

* utilización de "que" para comenzar todas las definiciones para evitar falta de concordancia de género y número (p.e. "Dado **que** tenemos tres personas")
* creación de nuevos recursos utilizando verbo **tener** en tercena persona plural (p.e. "Dado que **tenemos** tres lechugas")
* asignación de valores con el verbo **tener** en tercera persona (p.e. "Dado que dichas Acelgas **tienen** como variedad Amarilla de Lyon")
* todas las definiciones para "Cuando algo ocurre" (o *Then's*, ver más abajo) son válidas también como "Dado el contexto" incorporándoles el prefijo "que" (p.e. "Dado que visito la portada").

#### Creación de uno o varios registros asignándoles opcionalmente un nombre
    Dado que tenemos Un Producto llamado "Acelgas" 
[más ejemplos](master/features/contexto-creacion-simple.feature)

#### Creación de uno o varios recursos a partir de una **step table**
    Dado que tenemos el siguiente Huerto:
           | nombre   | área | latitud  | latitud   | abono   |
           | Secano-1 | 35   | N 40° 44 | W 003° 48 | FSF-315 |
[más ejemplos](master/features/contexto-creacion-desde-step-table.feature)

#### Asignación de un valor en un campo de un recurso concreto
    Dado que el Tomate "A" tiene como Variedad "Raf"
[más ejemplos](master/features/contexto-asignacion-de-valor-en-recurso.feature)

#### Asignación de un valor en un campo del último (o últimos) recurso mencionado
    Dado que dichas Acelgas tienen como Variedad "Gigante carmesí"
[más ejemplos](master/features/contexto-asignacion-de-valor-en-ultimo-recurso.feature)

#### Asignación simple a un campo **has\_many** del último recurso mencionado
    Dado que dicho Huerto tiene Tres Bancales "Acelgas, Tomates y Pepinos"
[más ejemplos](master/features/contexto-asignacion-has-many-simple.feature)

#### Asignación en campo **has\_many** del último recurso mencionado desde una step-table
    Dado que dicho Huerto tiene los siguientes Bancales:
           | nombre | longitud | cultivo |  matas |
           |  A-01  |    12    | Patatas |     16 |
           |  A-02  |    12    | Tomates |     18 |
[más ejemplos](master/features/contexto-asignacion-has-many-desde-fit-table.feature)

### Cuando algo ocurre (Whens)

Convenciones generales:

* frases escritas en primera persona del singular
* todas las definiciones son válidas también para definir contexto (en "Dados" o "Givens") incorporándoles el prefijo "que" (p.e. "Dado que visito la portada").

#### Solicitud de una URL específica opcionalmente indicada con un nombre coloquial
    Cuando visito la portada
[más ejemplos](master/features/cuando-visito-url-especifica.feature)
#### Solicitud de la URL asociada al último recurso definido
    Cuando visito su página
[más ejemplos](master/features/cuando-visito-url-de-recurso.feature)
#### Pincho en un enlace \*
    Cuando pulso el enlace "Volver"
[más ejemplos](master/features/cuando-pulso-el-enlace.feature)
#### Pincho/pulso un bóton (*submit*) \*
    Cuando pulso en el botón Enviar
[más ejemplos](master/features/cuando-pulso-el-boton.feature)
#### Adjunto un fichero (*file*) \*
    Cuando adjunto el fichero "images/cucumber.jpg" en Fotografía actual
[más ejemplos](master/features/cuando-adjunto-el-fichero.feature)
#### Elijo una opción (*radiobutton*) \*
    Cuando elijo el color "VERDE"
[más ejemplos](master/features/cuando-elijo-de-radiobutton.feature)
#### Marco (o desmarco) una casilla (*checkbox*) \*
    Cuando marco "color verde"
[más ejemplos](master/features/cuando-marco-el-checkbox.feature)
#### Relleno/completo un campo con un texto (*text* o *textarea*) \*
     Cuando completo 'nombre' con 'Wadus'
[más ejemplos](master/features/cuando-relleno-el-campo.feature)
#### Selecciono una opción de una lista (*select*) \*
[más ejemplos](master/features/cuando-selecciono-en-listado.feature)
     Cuando selecciono "Hortalizas" en el listado de "Tipos de cultivo"

### Entonces pasa (Thens)

Convenciones generales:

* frases escritas en primera persona del singular (excepto comprobaciones en bbdd)
* para expresar que algo es visible utiliza "veo" o "debo ver" (o "no veo" y "no debo ver")
* las comprobaciones del contenido de la base de datos se escriben haciendo una referencia explícita a la misma en primera persona del plural ("tenemos en base de datos") o en tercera del singular ("tiene en base de datos"). Esta verbosidad es intencionada debido a que [dichas comprobaciones están desaconsejadas](http://github.com/aslakhellesoy/cucumber/wikis/given-when-then), haciendo así menos limpio y un poco más costoso su uso.

#### Veo (o no) un texto \*
    Entonces debo ver el texto "IVA incluido"
[más ejemplos](master/features/veo-el-texto.feature)
#### Veo (o no) una etiqueta HTML opcionalmente con un contenido concreto
    Entonces no debo ver la etiqueta div#title con el valor "Surco"
[más ejemplos](master/features/veo-etiqueta-con-valor.feature)
#### Veo marcada (o desmarcada) una casilla (*checkbox*) \*
    Y veo marcado "Acepto las condiciones del servicio"
[más ejemplos](master/features/veo-el-checkbox.feature)

#### Tenemos en BBDD uno o más registros de un modelo opcionalmente con un nombre concreto
    Entonces tenemos en la base de datos un Abono llamado "FSF-03"
[más ejemplos](master/features/tenemos-en-bbdd-registros.feature)

#### Tenemos en BBDD un valor en un campo de un registro concreto
    Entonces el Huerto "H-02" tiene en base de datos como Área "2" hectáreas
[más ejemplos](master/features/tenemos-en-bbdd-valor-en-campo-de-registro.feature)

#### Tenemos en BBDD un valor en un campo del registro mencionando anteriormente
    Entonces tiene en base de datos como Área "2" hectáreas
[más ejemplos](master/features/tenemos-en-bbdd-valor-en-campo-de-registro-mencionado.feature)

#### Tenemos en BBDD una asociación **has\_many** en un registro concreto
    Entonces el Huerto "H-02" tiene en base de datos un Bancal "A"
[más ejemplos](master/features/tenemos-en-bbdd-asocioacion-has-many-en-registro.feature)

#### Tenemos en BBDD una asociación **has\_many**  en un registro mencionando anteriormente
    Entonces tiene en base de datos un Bancal "B"
[más ejemplos](master/features/tenemos-en-bbdd-asocioacion-has-many-en-registro-mencionado.feature)


## License

Copyright 2008, The Cocktail Experience. Fernando García Samblas <fernando.garcia at the-cocktail.com>

This is free software released under the GPL License (see license agreement in COPYING).
