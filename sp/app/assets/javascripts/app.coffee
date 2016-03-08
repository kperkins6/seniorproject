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
      .when('/tags',
        templateUrl: "index.html"
        controller: 'TagsController'
      ).when('/tags/new',
        templateUrl: "form.html"
        controller: 'TagController'
      ).when('/tags/:tagId',
        templateUrl: "show.html"
        controller: 'TagController'
      ).when('/tags/:tagId/edit',
        templateUrl: "form.html"
        controller: 'TagController'
      ).when('/businesscards',
        templateUrl: "cardsindex.html"
        controller: "BusinessCardsController"
      ).when('/businesscards/:businesscardId',
        templateUrl: "cardshow.html"
        controller: 'BusinessCardController'
      ).when('/businesscards/new',
        templateUrl: "cardsform.html"
        controller: 'BusinessCardController'
      ).when('/businesscards/:businesscardId/edit',
        templateUrl: "cardsform.html"
        controller: 'BusinessCardController'
      )
])

controllers = angular.module('controllers',[])
