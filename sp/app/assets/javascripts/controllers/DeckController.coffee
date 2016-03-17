controllers = angular.module('controllers')
controllers.controller("DeckController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Deck = $resource('/decks/:deckId', { deckId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.deckId
      Deck.get({deckId: $routeParams.deckId},
        ( (deck)-> $scope.deck = deck ),
        ( (httpResponse)->
          $scope.deck = null
          flash.error   = "There is no deck with ID #{$routeParams.deckId}"
        )
      )
    else
      $scope.deck = {}

    $scope.back   = -> $location.path("/decks")
    $scope.edit   = -> $location.path("/decks/#{$scope.deck.id}/edit")
    $scope.cancel = ->
      if $scope.deck.id
        $location.path("/decks/#{$scope.deck.id}")
      else
        $location.path("/decks")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.deck.id
        $scope.deck.$save(
          ( ()-> $location.path("/decks/#{$scope.deck.id}") ),
          onError)
      else
        Deck.create($scope.deck,
          ( (newDeck)-> $location.path("/decks/#{newDeck.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.deck.$delete()
      $scope.back()

])
