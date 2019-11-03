angular.module 'appSystem'

.controller 'StepCtrl', [
  'Step'
  (Step) ->
    vm = @

    vm.init = (board)->
      vm.board = board
      vm.steps = vm.board?.steps || []

    vm.form =
      init: (step, @modal=false)->
        if step
          @params = angular.copy step
        else
          @params = title: ''

        if @modal
          $('#stepModal').modal('show')
        else
          @editing = true
      cancel: ->
        @params = {}
        if @modal
          $('#stepModal').modal('hide')
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
        params.board_id = vm.board.id
        Step[action] params,
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

        Step.destroy id: params.id,
          (data)->
            vm.loading = false
            console.log 'data', data
            vm.boards.removeById params.id
            vm.currentBoard = null
            closures.handle()
            callback?(data)
          (response)->
            vm.loading = false
            console.log 'response', response
      handle: (items...)->
        items = items.flattenCompact()
        vm.steps ||= []

        for item in items
          vm.steps.addOrExtend item

    vm
]
