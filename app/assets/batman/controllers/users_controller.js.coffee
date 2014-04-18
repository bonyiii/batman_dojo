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
    @user.urlPrefix = 'http://js-assessment-backend.herokuapp.com'
    @user.url = "users.json"
    @user.save()

  update: (params) ->
    @user.urlPrefix = 'http://js-assessment-backend.herokuapp.com'
    @user.url = "users.json"
    @user.save()

  destroy: (params) ->

  toggle_lock: (node, event, context) ->
    user = if context.get('user') then context.get('user') else @user 
    user.set('status', user.get('opposite_status'))
    user.urlPrefix = 'http://js-assessment-backend.herokuapp.com'
    user.url = "users/#{user.get('id')}.json"
    user.save()

  paginate: =>
    @users.clear()
    for item in @all_users.toArray()[(@page*@size)..(((@page + 1) * @size) - 1)]
      @users.add(item)

  first_page: ->
    @page == 0

