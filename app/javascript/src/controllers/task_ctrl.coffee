angular.module 'appSystem'

.controller 'TaskCtrl', [
  'Task'
  (Task) ->
    vm = @

    vm.init = (step)->
      vm.step = step
      vm.tasks = vm.step?.tasks || []

    vm.form =
      init: (task, @modal=false)->
        if task
          @params = angular.copy task
        else
          @params = title: ''

        if @modal
          $('#taskModal').modal('show')
        else
          @editing = true
      cancel: ->
        @params = {}
        if @modal
          $('#taskModal').modal('hide')
        else
          @editing = false
      submit: ->
        closures.save @params, ->
          vm.form.cancel()
      destroy: ->
        closures.destroy @params

    closures =
      save: (params, callback)->
        return if vm.loading
        vm.loading = true

        action = if params.id then 'update' else 'create'
        params.step_id = vm.step.id
        Task[action] params,
          (data)->
            vm.loading = false
            console.log 'data', data
            closures.handle data
            callback?(data)
          (response)->
            vm.loading = false
            console.log 'response', response
      destroy: (params, callback)->
        unless confirm("Tem certeza que deseja destruir o Quadro #{params.title}?")
          return

        return if vm.loading
        vm.loading = true

        Task.destroy id: params.id,
          (data)->
            vm.loading = false
            console.log 'data', data
            vm.tasks.removeById params.id
            callback?(data)
          (response)->
            vm.loading = false
            console.log 'response', response
      handle: (items...)->
        items = items.flattenCompact()
        vm.tasks ||= []

        for item in items
          vm.tasks.addOrExtend item

    vm
]
