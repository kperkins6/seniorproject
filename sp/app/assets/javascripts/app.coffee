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
      )
])


businesscards = [
  {
    id: 1
    name: 'John Doe'
  },
  {
    id: 2
    name: 'Jane Doe'
  },
  {
    id: 3
    name: 'Tyson Henry'
  },
]

controllers = angular.module('controllers',[])
controllers.controller("BusinessCardsController", [ '$scope', '$routeParams', '$location',
  ($scope,$routeParams,$location)->
    $scope.search = (keywords)->  $location.path("/businesscards").search('keywords',keywords)

    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.businesscards = businesscards.filter (businesscard)-> businesscard.name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.businesscards = []
])
