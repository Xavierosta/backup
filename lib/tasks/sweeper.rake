namespace :sweeper do

  desc "TODO"
  task setup_logger: :environment do
    if defined?(Rails)
      Rails.logger = Logger.new(STDOUT)
      Rails.logger.level = Logger::INFO if not (Rails.env == 'development')
    end
  end

  desc "TODO"
  task go: :environment do
    begin
      include DropboxManager
      move_files
    rescue DropboxError => msg
      puts msg
    rescue DropboxAuthError => msg
      puts msg
    end
  end

  desc "TODO"
  task recorder_archive: :environment do
    begin
      include DropboxManager
      recorder_archive
    rescue DropboxError => msg
      puts msg
    rescue DropboxAuthError => msg
      puts msg
    end
  end

  desc "TODO"
  task backup: :environment do
    begin
      include DropboxManager
      backup
    rescue DropboxError => msg
      puts msg
    rescue DropboxAuthError => msg
      puts msg
    end
  end

end
