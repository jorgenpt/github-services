class Service::Bugly < Service
  string :project_id, :account_name, :token
  white_list :project_id, :account_name

  def receive_push
    http.ssl[:verify] = false # :(
    http_post "https://#{data['account_name']}.bug.ly/changesets.json?service=github&project_id=#{data['project_id']}",
      JSON.generate(payload),
      'X-BuglyToken' => data['token'],
      'Content-Type' => 'application/json'
    return
  end
end
