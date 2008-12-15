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
  Además de los clásicos **cucumber**, **webrat**, **rspec** y **rspec-rails** es necesaria la instalación los plugins de FixtureReplacement y StringMapper:

* fixture_replacement (http://replacefixtures.rubyforge.org/)

    $ script/plugin install http://thmadb.com/public_svn/plugins/fixture_replacement2/
    $ script/generate fixture_replacement

* string-mapper (http://github.com/nando/string-mapper)

    $ script/plugin install git://github.com/nando/string-mapper.git

## Definiciones en MundoPepino
### Dado el contexto (Givens)

* [Creación de uno o varios registros asignándoles opcionalmente un nombre](master/features/creacion-simple.feature)
* [Creación de uno o varios recursos a partir de una **step table**](master/features/creacion-desde-step-table.feature)
* [Asignación de un valor en un campo del último (o últimos) recurso mencionados](master/features/asignacion-de-valor.feature)

### Cuando algo ocurre (Whens)

* Solicitud de una URL específica opcionalmente indicada con un nombre coloquial
* Solicitud de la URL asociada al último recurso definido

### Entonces pasa (Thens)

* Tenemos (o no) una etiqueta HTML opcionalmente con un contenido concreto

## License

Copyright 2008, Fernando García Samblas <fernando.garcia at the-cocktail.com>

This software is released under the GPL License (see license agreement in COPYING).
