require './intercom_client'
require './user_tasks'

class EventTasks < IntercomClient
  def initialize()
    #Override initialize in IntercomClient
  end

  def submit_event(name, time, criteria, meta_data=false)
    #First check if the user exists,
    #It will throw an exception if it fails to find a user
    user = UserTasks.new()
    usr = user.find_user(criteria)

    #create a hash to pass through to the event API
    event = {:event_name => name,
             :created_at => time,
             :email => usr.email}

    #Check if we need to add metadata to the event
    if meta_data
      event[:metadata] = meta_data
    end

    @@intercom.events.create(event)
  end

  def list_events(criteria)
    #First check if the user exists,
    #It will throw an exception if it fails to find a user
    user = UserTasks.new()
    usr = user.find_user(criteria)
    @@intercom.get("/events", type:"user", user_id:usr.user_id)
  end

  # def create_message
  #   intercom.messages.create({
  #                                message_type: 'email',
  #                                subject: 'Hey there',
  #                                body: "What's up :)",
  #                                template: "plain", # or "personal",
  #                                from: {
  #                                    type: "admin",
  #                                    id: intercom.admins.me.id
  #                                },
  #                                to: {
  #                                    type: "user",
  #                                    id: user.id
  #                                }
  #                            })
  # end
end