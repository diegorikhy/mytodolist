angular.module 'appSystem'

.controller 'BoardCtrl', [
  'Board'
  (Board) ->
    vm = @

    vm.init = ->
      closures.list ->
        boardId = localStorage.getItem('board_id')
        boardId = parseInt(boardId)

        if boardId
          board = vm.boards.getById(boardId)
        else
          board = vm.boards.first()

        vm.load(id: board.id) if board?.id

    vm.form =
      init: (board)->
        if board
          @params = angular.copy board
        else
          @params = title: ''

        $('#boardModal').modal('show')
      submit: ->
        closures.save @params, ->
          $('#boardModal').modal('hide')
      destroy: ->
        closures.destroy @params, ->
          $('#boardModal').modal('hide')

    vm.load = (board)->
      unless board
        vm.current = {}
        return

      closures.show board, ->
        localStorage.setItem('board_id', board.id)

    closures =
      list: (callback)->
        Board.list {},
        (data)->
          closures.handle data.items
          callback?()
        (response)->
          alert response.data?.errors
      show: (board, callback)->
        return if vm.loading || !board.id
        vm.loading = true

        Board.show id: board.id,
          (data)->
            vm.loading = false
            vm.current = data
            closures.handle data
            callback?(data)
          (response)->
            vm.loading = false
            alert response.data?.errors
      save: (params, callback)->
        return if vm.loading
        vm.loading = true

        action = if params.id then 'update' else 'create'
        Board[action] params,
          (data)->
            vm.loading = false
            closures.handle data

            vm.load(data) if action == 'create'
            callback?(data)
          (response)->
            vm.loading = false
            alert response.data?.errors
      destroy: (params, callback)->
        unless confirm("Tem certeza que deseja destruir o Quadro #{params.title}?")
          return

        return if vm.loading
        vm.loading = true

        Board.destroy id: params.id,
          (data)->
            vm.loading = false
            vm.boards.removeById params.id

            vm.load(vm.boards.first())
            callback?(data)
          (response)->
            vm.loading = false
            alert response.data?.errors
      handle: (items...)->
        items = items.flattenCompact()
        vm.boards ||= []

        for item in items
          vm.boards.addOrExtend item
          if vm.current?.id == item.id
            vm.current = item

    vm
]
