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
      .when('/',
        templateUrl: "index.html"
        controller: 'TagsController'
      ).when('/tags/:tagId',
        templateUrl: "show.html"
        controller: 'TagController'
      )
])

tags = [
  {
    id: 1
    text: 'Baked Potato w/ Cheese'
    hits: 5
  },
  {
    id: 2
    text: 'Garlic Mashed Potatoes',
    hits: 2
  },
  {
    id: 3
    text: 'Potatoes Au Gratin',
    hits: 3
  },
  {
    id: 4
    text: 'Baked Brussel Sprouts',
    hits: 4
  },
]

controllers = angular.module('controllers',[])

