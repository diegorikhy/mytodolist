angular.module 'appSystem'

.controller 'BoardCtrl', [
  'Board'
  (Board) ->
    vm = @

    vm.init = ->
      closures.list()

    vm.form =
      init: (board={})->
        @params    = title: ''
        @newRecord = !!board.id
        console.log 'FORM INIT'

        $('#boardModal').modal('show')
      submit: ->
        console.log 'FORM SUBMIT'
        closures.save @params, ->
          console.log 'FORM CALLBACK'
          $('#boardModal').modal('hide')

    closures =
      list: ->
        Board.list {},
        (data)->
          console.log 'data', data
          vm.boards = data.items
        (response)->
          console.log 'response', response
      save: (params, callback)->
        return if vm.loading
        vm.loading = true

        action = if params.id then 'update' else 'create'
        Board[action] params,
          (data)->
            vm.loading = false
            console.log 'data', data
            vm.boards.addOrExtend data
            callback?(data)
          (response)->
            vm.loading = false
            console.log 'response', response

    vm
]
