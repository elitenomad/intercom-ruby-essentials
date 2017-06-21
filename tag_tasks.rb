require './intercom_client'
require './user_tasks'

class TagTasks < IntercomClient
  def initialize()
  end

  # List all tags
  def show_tags()
    puts "Tag Name ---- Tag ID"
    @@intercom.tags.all.each {|tag| puts "#{tag.name} - #{tag.id}" }
  end

  # Tag the user under a group
  def tag_user(criteria, tag)
    user = UserTasks.new()
    usr = user.find_user(criteria)
    tag = @@intercom.tags.tag(name: tag, users: [{email: usr.email}])
  end

  # List tags based on user
  def show_attrib(criteria, attrib )
    #First we check whether this is a standard attribute
    user = UserTasks.new.find_user(criteria)
    user.send(attrib.to_sym)
  end

  # Tag multiple users
  def tag_users(users, tag)
    users.each {|criteria| tag_user(criteria, tag)}
  end

end