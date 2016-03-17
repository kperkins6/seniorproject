sp = angular.module('sp',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

sp.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/bcards/:bcardId/tags',
        templateUrl: "index.html"
        controller: 'TagsController'
      ).when('/bcards/:bcardId/tags/new',
        templateUrl: "form.html"
        controller: 'TagController'
      ).when('/bcards/:bcardId/tags/:tagId',
        templateUrl: "show.html"
        controller: 'TagController'
      ).when('/bcards/:bcardId/tags/:tagId/edit',
        templateUrl: "form.html"
        controller: 'TagController'
      ).when('/bcards',
        templateUrl: "cardsindex.html"
        controller: "BcardsController"
      ).when('/bcards/new',
        templateUrl: "cardsform.html"
        controller: 'BcardController'
      ).when('/bcards/:bcardId',
        templateUrl: "cardshow.html"
        controller: 'BcardController'
      ).when('/bcards/:bcardId/edit',
        templateUrl: "cardsform.html"
        controller: 'BcardController'
      ).when('/decks',
        templateUrl: "deckindex.html"
        controller: 'DecksController'
      ).when('/decks/new',
        templateUrl: "deckform.html"
        controller: 'DeckController'
      ).when('/decks/:deckId',
        templateUrl: "deckshow.html"
        controller: 'DeckController'
      ).when('/decks/:deckId/edit',
        templateUrl: "deckform.html"
        controller: 'DeckController'
      ).when('/tagcards',
        templateUrl: "tagcardsindex.html"
        controller: "TagcardsController"
      ).when('/tagcards/new',
        templateUrl: "tagcardsform.html"
        controller: 'TagcardController'
      ).when('/tagcards/:tagcardId',
        templateUrl: "tagcardshow.html"
        controller: 'TagcardController'
      ).when('/tagcards/:tagcardId/edit',
        templateUrl: "tagcardsform.html"
        controller: 'TagcardController'
      )
])

controllers = angular.module('controllers',[])
