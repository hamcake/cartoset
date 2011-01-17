module Admin::DashboardHelper

  def activity_message_for(record)

    if (activity = Refinery::Plugins.active.find_activity_by_model(record.class)).present? and activity.title.present?
      # work out which action occured
      action = record.updated_at.eql?(record.created_at) ? "created" : "updated"

      # get article to define gender of model name, some languages require this for proper grammar
      article = t("plugins.#{record.class.name.pluralize.downcase}.article", :default => 'the')

      # now create a link to the notification's corresponding record.
      # link = link_to t(".latest_activity_message",
      #                 :what => record.send(activity.title),
      #                 :kind => record.class.model_name.human,
      #                 :action => t("#{action}.with_article \"#{article}\"")
      #                 ).downcase.capitalize, eval("#{activity.url}(#{activity.nesting("record")}record)")
      name = record.send(activity.title).downcase.capitalize + ' ' + record.class.model_name.human
      date_in_words = time_ago_in_words(record.updated_at) + ' ' + t('admin.dashboard.recent_activity.ago')
      action_name = t('admin.dashboard.recent_activity.was') + ' ' + t("#{action}.with_article \"#{article}\"")
      href = eval("#{activity.url}(#{activity.nesting("record")}record)")
      return name, date_in_words, action_name, href
    end
  end

end
