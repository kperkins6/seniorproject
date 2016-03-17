controllers = angular.module('controllers')
controllers.controller("TagcardController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Tagcard = $resource('/tagcards/:tagcardId', { tagcardId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.tagcardId
      Tagcard.get({tagcardId: $routeParams.tagcardId},
        ( (tagcard)-> $scope.tagcard = tagcard ),
        ( (httpResponse)->
          $scope.tagcard = null
          flash.error   = "There is no tagcard with ID #{$routeParams.tagcardId}"
        )
      )
    else
      $scope.tagcard = {}

    $scope.back   = -> $location.path("/tagcards")
    $scope.edit   = -> $location.path("/tagcards/#{$scope.tagcard.id}/edit")
    $scope.cancel = ->
      if $scope.tagcard.id
        $location.path("/tagcards/#{$scope.tagcard.id}")
      else
        $location.path("/tagcards")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.tagcard.id
        $scope.tagcard.$save(
          ( ()-> $location.path("/tagcards/#{$scope.tagcard.id}") ),
          onError)
      else
        Tagcard.create($scope.tagcard,
          ( (newTagcard)-> $location.path("/tagcards/#{newTagcard.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.tagcard.$delete()
      $scope.back()

])
