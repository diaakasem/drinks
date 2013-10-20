angular.module('appApp')
  .directive('nav', function () {
    return {
      templateUrl: 'views/directives/nav.html',
      restrict: 'E',
      link: function postLink(scope, element, attrs) {
        element.text('this is the nav directive');
      }
    };
  });
