controllers = angular.module('controllers')
controllers.controller("DecksController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/decks").search('keywords',keywords)
    Deck = $resource('/decks/:deckId', { deckId: "@id", format: 'json' })

    if $routeParams.keywords
      Deck.query(keywords: $routeParams.keywords, (results)-> $scope.decks = results)
    else
      $scope.decks = []

    $scope.view = (deckId)-> $location.path("/decks/#{deckId}")

    $scope.newDeck = -> $location.path("/decks/new")
    $scope.edit      = (deckId)-> $location.path("/decks/#{deckId}/edit")
])
