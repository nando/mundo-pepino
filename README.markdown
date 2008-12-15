# mundo-pepino

## What's in this world...

Expresing our app behaviour with a natural language has to deal with the fact that **one sentence can be expresed in many different ways**.

This fact can easily drive us towards an **explosion of the step definitions** making the maintenance of our app more difficult. 

At the same time, to describe an app **there is a group of sentences that we're very likely to need**, like for example those which refer to posible interactions of the user while browsing a site.

Currently `script/generate cucumber` give to **English** cucumberists a proposal for some of those common steps in `step_definitions/webrat_steps.rb`.

mundo-pepino will be an already implemented set of step definitions frequently needed while writing a feature in **Spanish**, hopefully with all the `script/generate cucumber` proposals translated inside.

Bon appetit!

## Dado el contexto (Givens)

* [Creación de uno o varios registros asignándoles opcionalmente un nombre](features/creacion.feature)
* Creación de uno o varios recursos a partir de una **step table**
* Asignación de un valor en un campo del último (o últimos) recurso mencionados

## Cuando algo ocurre (Whens)

* Solicitud de una URL específica opcionalmente indicada con un nombre coloquial
* Solicitud de la URL asociada al último recurso definido

## Entonces pasa (Thens)

* Tenemos (o no) una etiqueta HTML opcionalmente con un contenido concreto

