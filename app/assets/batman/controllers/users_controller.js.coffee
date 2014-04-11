class Jstest.UsersController extends Jstest.ApplicationController
  routingKey: 'users'

  index: (params) ->
    @all_users = Jstest.User.get('all')

    @page = 0
    @size = 10

    @users = new Batman.Set
    @all_users.observe 'toArray', (new_array) =>
      @paginate()

    @set('users', @users)

  show: (params) ->
    Jstest.User.find params.id, @errorHandler (user) =>
      @set('user', user)

  edit: (params) ->

  new: (params) ->

  create: (params) ->

  update: (params) ->

  destroy: (params) ->


  paginate: =>
    @users.clear()
    for item in @all_users.toArray()[(@page*@size)..(((@page + 1) * @size) - 1)]
      @users.add(item)

  first_page: ->
    @page == 0
