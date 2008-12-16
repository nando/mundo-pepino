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

Sin embargo cada definición ha sido separada en un fichero `.feature` específico para poder enlazarlas desde el siguiente índice de las mismas:

### Dado el contexto (Givens)

* [Creación de uno o varios registros asignándoles opcionalmente un nombre](master/spec/features/creacion-simple.feature)
* [Creación de uno o varios recursos a partir de una **step table**](master/spec/features/creacion-desde-step-table.feature)
* [Asignación de un valor en un campo del último (o últimos) recurso mencionados](master/spec/features/asignacion-de-valor.feature)

### Cuando algo ocurre (Whens)

* [Solicitud de una URL específica opcionalmente indicada con un nombre coloquial](master/spec/features/url-especifica.feature)
* [Solicitud de la URL asociada al último recurso definido](master/spec/features/url-de-recurso.feature)

### Entonces pasa (Thens)

* [Tenemos (o no) una etiqueta HTML opcionalmente con un contenido concreto](master/spec/features/etiqueta-con-valor.feature)

## License

Copyright 2008, Fernando García Samblas <fernando.garcia at the-cocktail.com>

This software is released under the GPL License (see license agreement in COPYING).
