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

        return @editing = true unless @modal
        $("#taskModal#{vm.step.id}").modal('show')
      cancel: ->
        @params = {}
        return @editing = false unless @modal
        $("#taskModal#{vm.step.id}").modal('hide')
      submit: ->
        closures.save @params, ->
          vm.form.cancel()
      destroy: ->
        closures.destroy @params

    vm.sortable =
      dragControlListeners:
        itemMoved: (event)->
          task = event.source.itemScope.modelValue
          newStep = event.dest.sortableScope.$parent?.vmTask?.step
          return unless newStep

          params = id: task.id, step_id: newStep.id, skipStepId: true
          closures.save params

    closures =
      save: (params, callback)->
        return if vm.loading
        vm.loading = true

        action = if params.id then 'update' else 'create'
        params.step_id = vm.step.id unless params.skipStepId
        Task[action] params,
          (data)->
            vm.loading = false
            closures.handle data if data.step_id == vm.step.id
            callback?(data)
          (response)->
            vm.loading = false
            alert response.data?.errors
      destroy: (params, callback)->
        unless confirm("Tem certeza que deseja destruir o Quadro #{params.title}?")
          return

        return if vm.loading
        vm.loading = true

        Task.destroy id: params.id,
          (data)->
            vm.loading = false
            vm.tasks.removeById params.id
            callback?(data)
          (response)->
            vm.loading = false
            alert response.data?.errors
      handle: (items...)->
        items = items.flattenCompact()
        vm.tasks ||= []

        for item in items
          vm.tasks.addOrExtend item

    vm
]
