require_relative 'base'

# NOTE: using puts/print breaks things
class Search
  include Base

  attr_reader :query

  def initialize
    @query = ARGV.join(' ')
  end

  def search
    load_credentials
    output_json

  rescue => e
    if e.message.include?('No such file or directory @ rb_sysopen')
      setup_json
    else
      raise e
    end
  ensure
    print Base.workflow.output
  end

  private

  def load_credentials
    config = YAML.load_file("#{Base.dir_path}/settings.yml")
    Base.user_id = config['user_id']
    Base.api_token = config['api_token']
  end

  def output_json
    apps = fetch(query)
    return no_match_json if apps.empty?

    apps.each { |app| results_json(app) }
  end

  def fetch(query)
    apps = []
    if File.file?("#{Base.dir_path}/search.yml")
      apps = YAML.load_file("#{Base.dir_path}/search.yml")
    end

    if apps.empty?
      apps = fetch_app_list
    end

    apps.select{|app_name| app_name&.include?(query)}
  end

  def fetch_app_list
    response = HTTParty.get(
      "https://jenkins.ops.salsify.com/search/suggest?query=#{query}",
      :basic_auth => { :username => Base.user_id , :password => Base.api_token },
      :verify => false
    ).parsed_response

    apps = response['suggestions'].map {|app| app['name']}

    file_path = "#{Base.dir_path}/search.yml"
    FileUtils.touch(file_path) unless File.exist?(file_path)
    File.open(file_path, 'w') { |f| YAML.dump(apps, f) }

    apps
  end

  def results_json(app)
    url = "https://papertrailapp.com/systems/#{app}/events"

    Base.workflow.result
        .uid(app)
        .title(app)
        .subtitle(app)
        .quicklookurl(app)
        .arg(url)
        .text('copy', app)
        .autocomplete(app)
  end

  def no_match_json
    Base.workflow.result
        .title('No matches found!')
        .subtitle('Try a different search term')
        .valid(false)
        .icon('img/icon.png')
  end

  def setup_json
    Base.workflow.result
        .title('Jenkins is not set up yet!')
        .subtitle('Find your Jenkins User Id and API Token, then use the `jksetup` command.')
        .icon('img/icon.png')
  end
end

Search.new.search
