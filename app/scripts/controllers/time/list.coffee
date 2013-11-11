controller = (scope)->
  scope.show = (id)->
    $('.nav .active').removeClass('active')
    $('.tab-pane.active').removeClass('active')
    $('.nav-pills li#'+id).addClass 'active'
    $('.tab-pane#'+id).addClass 'active'
    ''

angular.module('drinksApp')
  .controller 'TimeListCtrl',
  ['$scope', controller]
