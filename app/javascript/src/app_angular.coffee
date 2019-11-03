angular.module 'appSystem', [
  'ngResource'
  'ngRoute'
  'ngSanitize'
  'as.sortable'
]

.config [
  '$routeProvider', '$locationProvider'
  ($routeProvider, $locationProvider)->
    $locationProvider.html5Mode true

    $routeProvider.when('/',
      templateUrl: boardPath
    )
    .otherwise({ redirectTo: '/' })
]

.run [
  '$rootScope', '$location'
  ($rootScope, $location)->
    $rootScope.$location = $location
]
