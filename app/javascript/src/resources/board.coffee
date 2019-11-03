angular.module 'appSystem'

.factory 'Board', [
  '$resource'
  ($resource) ->

    $resource '/boards/:id.json', {id: '@id'},
      show:
        method: 'GET'

      list:
        method: 'GET'

      create:
        method: 'POST'

      update:
        method: 'PUT'

      destroy:
        method: 'DELETE'
]


