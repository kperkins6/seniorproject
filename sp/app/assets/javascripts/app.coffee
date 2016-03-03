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
      ).when('/tags/new',
        templateUrl: "form.html"
        controller: 'TagController'
      ).when('/tags/:tagId',
        templateUrl: "show.html"
        controller: 'TagController'
      ).when('/tags/:tagId/edit',
        templateUrl: "form.html"
        controller: 'TagController'
      )
])

controllers = angular.module('controllers',[])
