angular.module 'appSystem'

.controller 'BoardCtrl', [
  'Board'
  (Board) ->
    vm = @

    vm.init = ->
      closures.list ->
        boardId = localStorage.getItem('board_id')
        boardId = parseInt(boardId) || vm.boards.first()?.id
        vm.load(id: boardId)

    vm.form =
      init: (board)->
        if board
          @params = angular.copy board
        else
          @params = title: ''

        $('#boardModal').modal('show')
      submit: ->
        console.log 'FORM SUBMIT'
        closures.save @params, ->
          console.log 'FORM CALLBACK'
          $('#boardModal').modal('hide')
      destroy: ->
        closures.destroy @params, ->
          console.log 'FORM CALLBACK'
          $('#boardModal').modal('hide')

    vm.load = (board)->
      closures.show board, ->
        localStorage.setItem('board_id', board.id)

    closures =
      list: (callback)->
        Board.list {},
        (data)->
          console.log 'data', data
          closures.handle data.items
          callback?()
        (response)->
          console.log 'response', response
      show: (board, callback)->
        return if vm.loading || !board.id
        vm.loading = true

        Board.show id: board.id,
          (data)->
            vm.loading = false
            console.log 'data', data
            vm.current = data
            closures.handle data
            callback?(data)
          (response)->
            vm.loading = false
            console.log 'response', response
      save: (params, callback)->
        return if vm.loading
        vm.loading = true

        action = if params.id then 'update' else 'create'
        Board[action] params,
          (data)->
            vm.loading = false
            console.log 'data', data
            closures.handle data

            vm.load(data) if action == 'create'
            callback?(data)
          (response)->
            vm.loading = false
            console.log 'response', response
      destroy: (params, callback)->
        unless confirm("Tem certeza que deseja destruir o Quadro #{params.title}?")
          return

        return if vm.loading
        vm.loading = true

        Board.destroy id: params.id,
          (data)->
            vm.loading = false
            console.log 'data', data
            vm.boards.removeById params.id

            vm.load(vm.boards.first())
            callback?(data)
          (response)->
            vm.loading = false
            console.log 'response', response
      handle: (items...)->
        items = items.flattenCompact()
        vm.boards ||= []

        for item in items
          vm.boards.addOrExtend item
          if vm.current?.id == item.id
            vm.current = item

    vm
]
