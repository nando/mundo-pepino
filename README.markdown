# MundoPepino

Welcome to MundoPepino!

First of all, please note that this README is also available and (still) much more complete in [Spanish](http://github.com/nando/mundo-pepino/blob/master/README_es.markdown).

## Presentation

Expresing our app behaviour with a natural language has to deal with the fact that **one sentence can be expresed in many different ways**.

This fact can easily drive us towards an **explosion of the step definitions** making the maintenance of our app more difficult.

At the same time, to describe an app **there is a group of sentences that we're very likely to need**, like for example those which refer to posible interactions of the user while browsing a site.

MundoPepino is a set of reusable step definitions to test Rails apps with Cucumber.

**DISCLAIMER**:

MundoPepino was originally implemented to write features in Spanish. Its code has been recently modified to support different languages (and, theoretically, at the same time if needed).

Currently only part of the original set of steps (and just a little of the documentation) has been translated to English. On the other hand features written in English don't have to manage the complexity added by translations of models and attributes. Cousin projects like [pickle](http://github.com/ianwhite/pickle) or [email-spec](http://github.com/bmabey/email-spec) are much more advanced to write features in English.

For other languages, before start your own implementation, it'd be nice if you:

* start a new language in MundoPepino (we'll be glad to help you if you try), or
* look for your language in [similar i18n projects](http://groups.google.com/group/cukes/browse_thread/thread/b9b8ff6301393c19/febf6530a1ed1a37).

## Resources

* **sources**: git://github.com/nando/mundo-pepino.git
* **todo**: [github issues](http://github.com/nando/mundo-pepino/issues)
* **list**: [google group](http://groups.google.es/group/mundo-pepino)
* **gem**: mundo-pepino

## Definitions

### Givens/Whens
#### Simple instance/s creation optionally with its/their name/s
    Given three orchards called "H-01, H-02 y H-03"
[more examples](mundo-pepino/tree/master/features/en_US/simple-creation.feature)

#### Page request
    Given I am on the homepage
[more examples](mundo-pepino/tree/master/features/en_US/page-request.feature)

### Thens
#### I see (or not) a text
    Then I should see the text "Hello!"
[more examples](mundo-pepino/tree/master/features/en_US/i-see-the-text.feature)


## License

Copyright 2009, The Cocktail Experience. Fernando García Samblas <fernando.garcia at the-cocktail.com>

This is free software released under the GPL License (see license agreement in COPYING).
