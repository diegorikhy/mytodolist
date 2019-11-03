angular.module 'appSystem'

.factory 'Step', [
  '$resource'
  ($resource) ->
    encapsulateData = (data)->
      JSON.stringify { 'step': data }

    $resource '/steps/:id.json', id: '@id',
      create:
        method: 'POST'
        transformRequest: encapsulateData

      update:
        method: 'PUT'
        transformRequest: encapsulateData

      destroy:
        method: 'DELETE'
]


