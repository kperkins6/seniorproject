controllers = angular.module('controllers')
controllers.controller("BusinessCardsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/businesscards").search('keywords',keywords)
    BusinessCard = $resource('/businesscards/:businesscardId', { businesscardId: "@id", format: 'json' })

    if $routeParams.keywords
      BusinessCard.query(keywords: $routeParams.keywords, (results)-> $scope.businesscards = results)
    else
      $scope.businesscards = []

    $scope.view = (businesscardId)-> $location.path("/businesscards/#{businesscardId}")

    $scope.newBusinessCard = -> $location.path("/businesscards/new")
    $scope.edit      = (businesscardId)-> $location.path("/businesscards/#{businesscardId}/edit")
])
