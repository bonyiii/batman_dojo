class Jstest.User extends Batman.Model
  @resourceName: 'users'
  @storageKey: 'users'
  @persist Batman.RailsStorage, { 
    urlPrefix: -> 'http://js-assessment-backend.herokuapp.com', 
    urlSuffix: -> ".json" }

  @encode "id", "first_name", "last_name", "status", "created_at"
  @encodeTimestamps()

  @accessor 'name', ->
    "#{@get('first_name')} #{@get('last_name')}"

  @accessor 'opposite_status', ->
    if @get('status') == 'active'
      'locked'
    else
      'active'

  @accessor 'whatever', ->
    if true
      @set('status', 'active')
    else
      @set('status', 'locked')

