require_relative 'lib/alfred-workflow-ruby/alfred-3_workflow'
require_relative 'lib/httparty/httparty'

require 'fileutils'
require 'yaml'

module Base
  class << self
    attr_reader :workflow, :dir_path
    attr_accessor :url, :user_id, :api_token
  end

  @workflow  = Alfred3::Workflow.new
  @dir_path  = FileUtils.mkdir_p("#{ENV['HOME']}/Library/Application Support/Alfred 3/Workflow Data/app.kevinyang.jenkins.alfredworkflow").first
end
