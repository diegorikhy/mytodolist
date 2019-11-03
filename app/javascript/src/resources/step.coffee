angular.module 'appSystem'

.factory 'Step', [
  '$resource'
  ($resource) ->
    encapsulateData = (data)->
      JSON.stringify { 'step': data }

    $resource '/steps/:id.json', id: '@id',
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


