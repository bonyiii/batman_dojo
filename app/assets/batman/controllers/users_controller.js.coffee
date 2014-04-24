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
    Jstest.User.find params.id, @errorHandler (user) =>
      @set('user', user)

  new: (params) ->
    @set('user', new Jstest.User)

  create:  ->
    @user.save (err, user) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @redirect user

  update: (params) ->
    @user.save (err, user) =>
      console.log(arguments)
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @redirect user

  destroy: (params) ->

  toggle_lock: (node, event, context) ->
    user = if context.get('user') then context.get('user') else @user 
    user.set('status', user.get('opposite_status'))
    user.save()

  paginate: =>
    @users.clear()
    for item in @all_users.toArray()[(@page*@size)..(((@page + 1) * @size) - 1)]
      @users.add(item)

  first_page: ->
    @page == 0

