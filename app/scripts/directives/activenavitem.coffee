"use strict"
angular.module("drinksApp").directive "activenavitem", ($location) ->
  restrict: "A"
  link: postLink = (scope, element, attrs, controller) ->
    
    # Watch for the $location
    scope.$watch (->
      $location.path()
    ), (newValue, oldValue) ->
      $("li[matches]", element).each (k, li) ->
        $li = angular.element(li)
        # data('match-route') does not work with dynamic attributes
        pattern = $li.attr("matches")
        console.log pattern
        regexp = new RegExp("^" + pattern + "$", ["i"])
        if regexp.test(newValue)
          $li.addClass "active"
          $collapse = $li.find(".collapse.in")
          $collapse.collapse "hide"  if $collapse.length
        else
          $li.removeClass "active"



