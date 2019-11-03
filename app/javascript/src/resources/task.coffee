angular.module 'appSystem'

.factory 'Task', [
  '$resource'
  ($resource) ->
    encapsulateData = (data)->
      JSON.stringify { 'task': data }

    $resource '/tasks/:id.json', id: '@id',
      create:
        method: 'POST'
        transformRequest: encapsulateData

      update:
        method: 'PUT'
        transformRequest: encapsulateData

      destroy:
        method: 'DELETE'
]


