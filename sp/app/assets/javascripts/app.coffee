sp = angular.module('sp',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
])

sp.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'TagsController'
      )
])

tags = [
  {
    id: 1
    name: 'Baked Potato w/ Cheese'
  },
  {
    id: 2
    name: 'Garlic Mashed Potatoes',
  },
  {
    id: 3
    name: 'Potatoes Au Gratin',
  },
  {
    id: 4
    name: 'Baked Brussel Sprouts',
  },
]

controllers = angular.module('controllers',[])
controllers.controller("TagsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)

    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.tags = tags.filter (tag)-> tag.name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.tags = []
])

