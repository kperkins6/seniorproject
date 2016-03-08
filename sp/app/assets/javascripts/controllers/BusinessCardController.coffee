controllers = angular.module('controllers')
controllers.controller("BusinessCardController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    BusinessCard = $resource('/businesscards/:businesscardId', { businesscardId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.businesscardId
      BusinessCard.get({businesscardId: $routeParams.businesscardId},
        ( (businesscard)-> $scope.businesscard = businesscard ),
        ( (httpResponse)->
          $scope.businesscard = null
          flash.error   = "There is no businesscard with ID #{$routeParams.businesscardId}"
        )
      )
    else
      $scope.businesscard = {}

    $scope.back   = -> $location.path("/businesscards")
    $scope.edit   = -> $location.path("/businesscards/#{$scope.businesscard.id}/edit")
    $scope.cancel = ->
      if $scope.businesscard.id
        $location.path("/businesscards/#{$scope.businesscard.id}")
      else
        $location.path("/businesscards")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.businesscard.id
        $scope.businesscard.$save(
          ( ()-> $location.path("/businesscards/#{$scope.businesscard.id}") ),
          onError)
      else
        BusinessCard.create($scope.businesscard,
          ( (newBusinessCard)-> $location.path("/businesscards/#{newBusinessCard.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.businesscard.$delete()
      $scope.back()

])
