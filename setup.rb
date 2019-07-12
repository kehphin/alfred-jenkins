require_relative 'base'

class Setup
  include Base

  attr_reader :url
  attr_reader :user_id
  attr_reader :api_token

  def initialize
    @url = ARGV[0].split(' ')[0]
    @user_id = ARGV[0].split(' ')[1]
    @api_token = ARGV[0].split(' ')[2]
  end

  def setup
    save_credentials
    output_json
  end

  private

  def save_credentials
    file_path = "#{Base.dir_path}/settings.yml"
    FileUtils.touch(file_path) unless File.exist?(file_path)
    config = YAML.load_file(file_path) || {}

    config['url'] = url
    config['user_id'] = user_id
    config['api_token'] = api_token
    File.open(file_path, 'w') { |f| YAML.dump(config, f) }
  end

  def output_json
    Base.workflow.result
        .title(ARGV[0])
        .subtitle('Set Jenkins Credentials')
        .type('default')
        .valid(true)
        .icon('img/icon.png')
        .arg('')

    print Base.workflow.output
  end
end

Setup.new.setup
