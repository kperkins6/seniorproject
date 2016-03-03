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
    text: 'Baked Potato w/ Cheese'
    hits: 1
  },
  {
    id: 2
    text: 'Garlic Mashed Potatoes',
    hits: 3
  },
  {
    id: 3
    text: 'Potatoes Au Gratin',
    hits: 2
  },
  {
    id: 4
    text: 'Baked Brussel Sprouts',
    hits: 5
  },
]

controllers = angular.module('controllers',[])
controllers.controller("TagsController", ['$scope', '$routeParams', '$location',
  ($scope,$routeParams,$location)->
    $scope.search = (keywords)-> $location.path("/").search('keywords',keywords)

    if $routeParams.keywords
     keywords - $routeParams.keywords.toLowerCase()
     $scope.tags = tags.filter (tag)-> tag.name.toLowerCase().indexOf(keywords) != -1
    else
     $scope.tag = []
])
