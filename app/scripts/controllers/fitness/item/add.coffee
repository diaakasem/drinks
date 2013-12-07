'use strict'
controller = (scope, ParseCrud)->
  Items = new ParseCrud 'Items'
  ItemsRepo = new ParseCrud 'ItemsRepo', no

  scope.error = scope.success = ''
  scope.model = {}
  scope.model.isPublic = no

  success = (res)->
    console.log res
    scope.$apply ->
      scope.success = 'Saved successfully.'
      if scope.model.isPublic
        scope.model.isPublic = no
        ItemsRepo.save scope.model, success, error
      scope.model.name = ''
      scope.model.brief = ''

  error = (e)->
    console.log e
    scope.$apply ->
      scope.success = 'Error occured'
    
  scope.save = (form)->
    Items.save scope.model, success, error

  scope.images = _.map [
    "-01.png", "-04.png", "-07.png", "-10.png", "-13.png", "-16.png", "-19.png", "-22.png", "-25.png", "-28.png", "-31.png", "-34.png", "-37.png", "-40.png", "-43.png", "-46.png", "-02.png", "-05.png", "-08.png", "-11.png", "-14.png", "-17.png", "-20.png", "-23.png", "-26.png", "-29.png", "-32.png", "-35.png", "-38.png", "-41.png", "-44.png", "-47.png", "-03.png", "-06.png", "-09.png", "-12.png", "-15.png", "-18.png", "-21.png", "-24.png", "-27.png", "-30.png", "-33.png", "-36.png", "-39.png", "-42.png", "-45.png", "-48.png",
  ], (d)-> "/images/items/drinkes/#{d}"

  scope.model.image = scope.images[0]

  scope.setImage = (imgPath)->
    scope.model.image = imgPath

angular.module('manageApp')
  .controller 'FitnessItemAddCtrl',
  ['$scope', 'ParseCrud', controller]
