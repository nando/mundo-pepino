# mundo-pepino

## What's in this world...

Expresing our app behaviour with a natural language has to deal with the fact that **one sentence can be expresed in many different ways**.

This fact can easily drive us towards an **explosion of the step definitions** making the maintenance of our app more difficult.

At the same time, to describe an app **there is a group of sentences that we're very likely to need**, like for example those which refer to posible interactions of the user while browsing a site.

Currently `script/generate cucumber` give to **English** cucumberists a proposal for some of those common steps in `step_definitions/webrat_steps.rb`.

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

    Característica: implementación de pasos genéricos
      Para escribir sólo la definición de los pasos específicos de mi proyecto
      Como usuario de Cucumber
      Quiero tener una serie de definiciones genéricas implementadas

Sin embargo cada definición ha sido separada en un fichero `.feature` específico para poder enlazarlas desde este índice. Los **asteriscos (\*)** al final de la definición hacen referencia a las **definiciones oficialmente comunes** generadas en inglés por `script/generate cucumber`.

### Dado el contexto (Givens)

* [Creación de uno o varios registros asignándoles opcionalmente un nombre](master/features/contexto-creacion-simple.feature)
* [Creación de uno o varios recursos a partir de una **step table**](master/features/contexto-creacion-desde-step-table.feature)
* [Asignación de un valor en un campo del último (o últimos) recurso mencionado](master/features/contexto-asignacion-de-valor.feature)
* [Asignación de valores en un campo **has_many** del último recurso mencionado](master/features/contexto-asignacion-de-valores-has-many.feature)

### Cuando algo ocurre (Whens)

* [Solicitud de una URL específica opcionalmente indicada con un nombre coloquial](master/features/cuando-visito-url-especifica.feature)
* [Solicitud de la URL asociada al último recurso definido](master/features/cuando-visito-url-de-recurso.feature)
* [Pincho en un enlace \*](master/features/cuando-pulso-el-enlace.feature)
* [Pincho en un bóton (*submit*) \*](master/features/cuando-pulso-el-boton.feature)
* [Adjunto un fichero (*file*) \*](master/features/cuando-.feature)
* [Elijo una opción (*radiobutton*) \*](master/features/cuando-elijo-de-radiobutton.feature)
* [Marco (o desmarco) una casilla (*checkbox*) \*](master/features/cuando-marco-el-checkbox.feature)
* [Relleno un campo con un texto (*text* o *textarea*) \*](master/features/cuando-relleno-el-campo.feature)
* [Selecciono una opción de una lista (*select*) \*](master/features/cuando-selecciono-en-listado.feature)

### Entonces pasa (Thens)

* [Veo (o no) un texto \*](master/features/veo-el-texto.feature)
* [Veo (o no) una etiqueta HTML opcionalmente con un contenido concreto](master/features/veo-etiqueta-con-valor.feature)
* [Veo marcada (o desmarcada) una casilla (*checkbox*) \*](master/features/veo-el-checkbox.feature)

## License

Copyright 2008, Fernando García Samblas <fernando.garcia at the-cocktail.com>

This is free software released under the GPL License (see license agreement in COPYING).
