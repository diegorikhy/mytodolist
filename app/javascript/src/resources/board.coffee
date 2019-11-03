angular.module 'appSystem'

.factory 'Board', [
  '$resource'
  ($resource) ->
    encapsulateData = (data)->
      JSON.stringify { 'board': data }

    $resource '/boards/:id.json', id: '@id',
      show:
        method: 'GET'

      list:
        method: 'GET'

      create:
        method: 'POST'
        transformRequest: encapsulateData

      update:
        method: 'PUT'
        transformRequest: encapsulateData

      destroy:
        method: 'DELETE'
]


