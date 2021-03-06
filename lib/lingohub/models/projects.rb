module Lingohub
  module Models
    require 'lingohub/models/project'

    class Projects

      PROJECT_URL = '/projects'

      def initialize(client)
        @client   = client
      end

      def all
        return @projects if defined? @projects
        @projects = {}
        response = JSON.parse @client.get(PROJECT_URL).to_s
        response["members"].each do |member|
          project = Lingohub::Models::Project.new(@client, member["links"][0]["href"])
          @projects[member["title"]] = project
        end
        @projects
      end

      def [](project_title)
        return all[project_title]
      end

    end
  end
end
