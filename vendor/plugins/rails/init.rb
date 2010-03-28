Refinery::Plugin.register do |plugin|
  plugin.title = "Jobs"
  plugin.description = "Manage Jobs"
  plugin.version = 1.0
  plugin.activity = {
    :class => Job,
    :url_prefix => "edit",
    :title => 'job_title'
  }
end
