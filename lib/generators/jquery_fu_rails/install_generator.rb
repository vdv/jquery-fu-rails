require 'rails/generators'
require 'rails/generators/migration'

module JqueryFuRails
  class InstallGenerator < ::Rails::Generators::Base
    include ::Rails::Generators::Migration

    def self.source_root
      @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end

    def self.next_migration_number(dirname)
      Time.now.strftime("%Y%m%d%H%M%S")
    end

    def mount_engine
      route "mount JqueryFuRails::Engine => '/jqueryfu'"
    end

    def create_models
      [ :attachment ].each do |filename|
        template "models/#{filename}.rb", File.join('app/models', engine_dir, "#{filename}.rb")
      end

      template "uploaders/jquery_fu_rails_attachment_uploader.rb", File.join("app/uploaders", "jquery_fu_rails_attachment_uploader.rb")
    end

    def rake_db
      rake('jquery_fu_rails_engine:install:migrations')
    end

    protected

    def engine_dir
      'jquery_fu_rails'
    end

  end
end
