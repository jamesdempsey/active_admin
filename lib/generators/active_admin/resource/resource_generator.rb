module ActiveAdmin
  module Generators
    class ResourceGenerator < Rails::Generators::NamedBase
      desc "Installs ActiveAdmin in a rails 3 application"

      def self.source_root
        @_active_admin_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def generate_config_file
        template "admin.rb", "app/admin/#{file_path.gsub('/', '_').pluralize}.rb"
      end

      def columns
        if class_name.constantize.table_exists?
          columns = class_name.constantize.columns.map { |column| column.name.to_sym.inspect }
          columns.delete(':id')
          "index do\n    selectable_column\n    id_column\n    default_actions\n    column "\
          "#{columns.join("\n    column ")}\n  end"
        end
      end

    end
  end
end
