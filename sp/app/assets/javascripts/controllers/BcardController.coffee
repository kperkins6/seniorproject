controllers = angular.module('controllers')
controllers.controller("BcardController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Bcard = $resource('/bcards/:bcardId', { bcardId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.bcardId
      Bcard.get({bcardId: $routeParams.bcardId},
        ( (bcard)-> $scope.bcard = bcard ),
        ( (httpResponse)->
          $scope.bcard = null
          flash.error   = "There is no bcard with ID #{$routeParams.bcardId}"
        )
      )
    else
      $scope.bcard = {}

    $scope.back   = -> $location.path("/bcards")
    $scope.edit   = -> $location.path("/bcards/#{$scope.bcard.id}/edit")
    $scope.cancel = ->
      if $scope.bcard.id
        $location.path("/bcards/#{$scope.bcard.id}")
      else
        $location.path("/bcards")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.bcard.id
        $scope.bcard.$save(
          ( ()-> $location.path("/bcards/#{$scope.bcard.id}") ),
          onError)
      else
        Bcard.create($scope.bcard,
          ( (newBcard)-> $location.path("/bcards/#{newBcard.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.bcard.$delete()
      $scope.back()

])
