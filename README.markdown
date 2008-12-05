# mundo-pepino

## What's in this world...

Expresing our app behavour with a natural language has to deal with the fact that **one sentence can be expresed in many other ways**.

This fact can easily drive us towards an **explosion of the step definitions** making the maintenance of our app more difficult. 

At the same time, to describe an app **there is a group of sentences that we're very likely to need**, like for example those which refer to posible interactions of the user while browsing a site.

Currently 'script/generate cucumber' give to **English** cucumberists a proposal for some of those common steps in step_definitions/webrat_steps.rb

mundo-pepino will be an already implemented set of step definitions frequently needed while writin a feature in **Spanish**, hopefully with all the 'script/generate cucumber' proposals translated inside.

Bon appetit!

## Dado el contexto (Givens)

Escenarios definidos/implementados:
* Creación de uno o varios registros con un nombre opcional
