controllers = angular.module('controllers')
controllers.controller("TagcardsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/tagcards").search('keywords',keywords)
    Tagcard = $resource('/tagcards/:tagcardId', { tagcardId: "@id", format: 'json' })

    if $routeParams.keywords
      Tagcard.query(keywords: $routeParams.keywords, (results)-> $scope.tagcards = results)
    else
      $scope.tagcards = []

    $scope.view = (tagcardId)-> $location.path("/tagcards/#{tagcardId}")

    $scope.newTag = -> $location.path("/tagcards/new")
    $scope.edit      = (tagcardId)-> $location.path("/tagcards/#{tagcardId}/edit")
])
