# This module contains functions which carry out operations with Dropbox API
module DropboxManager


  def move_files
    client = DropboxClient.new ENV['DROPBOX_ACCESS_TOKEN']
    path = ENV['MONITORED_PATH']

    data = client.metadata path
    count = 0
    data['contents'].each do |file|

      if not file['is_dir'] and file['bytes'] > (100*1024)
        from_path = file['path']
        filename = file['path'].split('/').last
        newfilename = filename
        fileext = filename.split('.').last
        minute = file['client_mtime'].to_datetime.min

        regex = b = /\(\d+\)\.(#{Movement::FILE_TYPES.join("|")})$/

        if filename.include? "conflicted copy" or regex.match filename
          puts "SWEEPERLOG: Skipping file #{from_path}"
          next
        end

        if not filename.starts_with?("DV-")
          if count == 0
            newfilename = "DV-#{DateTime.now.in_time_zone('EST').strftime('%Y-%m-%d-%H%M%S')}.#{filename.split('.').last}"
          else
            newfilename = "DV-#{DateTime.now.in_time_zone('EST').strftime('%Y-%m-%d-%H%M%S')}-#{count}.#{filename.split('.').last}"
          end
          count+= 1
        end

        if Movement::FILE_TYPES.include? fileext
          destination = Movement.find_by('tmin <= ? and tmax > ?',minute,minute).destination
          to_path = "#{destination}/#{newfilename}"
          response = client.file_move(from_path, to_path)
          puts "SWEEPERLOG: File #{from_path} moved to #{to_path}"
        end
      end
    end


  end


  def recorder_archive
    client = DropboxClient.new ENV['DROPBOX_ACCESS_TOKEN']
    path = "/VoiceRecorderHD"

    data = client.metadata path
    names = ["Kevin", "Mehmet", "Elissa", "Zachary", "Jordan", "Kyle", "Xavier", "Catherine",
             "Marcus", "Marinda", "Jacob"]

    data['contents'].each do |file|


      if not file['is_dir']
        from_path = file['path']
        filename = file['path'].split('/').last
        newfilename = filename
        fileext = filename.split('.').last

        regex = b = /\(\d+\)\.(#{Movement::FILE_TYPES.join("|")})$/

        if filename.include? "conflicted copy" or regex.match filename    #not 100% sure what this does but it looks like an error check I might as well include
          puts "SWEEPERLOG: Skipping file #{from_path}"
          next
        end

        if fileext == 'mp3'
          names.each do |name|
            conflictFlag = false
            archiveData = client.metadata "/RAs/Xavier/VoiceRecorderHDArchive/#{name}"
            archiveData['contents'].each do |archivedFile|
              if (archivedFile['path'].split('/').last).include? file['rev'] then conflictFlag = true end
            end
            if (filename.include? name) && (not conflictFlag)
              newfilename = name + " " + DateTime.now.to_s() + file['rev']
              to_path = "/RAs/Xavier/VoiceRecorderHDArchive/#{name}/#{newfilename}"
              response = client.file_copy(from_path, to_path)
              puts "SWEEPERLOG: File #{from_path} moved to #{to_path}"
            end

          end
        end
      end
    end

  end


  def backup
    client = DropboxClient.new ENV['DROPBOX_ACCESS_TOKEN']
    path = "/RAs/Xavier/Source"                               ############SOURCE DIRECTORY##############

    data = client.metadata path
    data['contents'].each do |file|

      if not file['is_dir']
        from_path = file['path']
        filename = file['path'].split('/').last #+ " " + file['rev']
        newfilename = filename
        #fileext = filename.split('.').last
        minute = file['client_mtime'].to_datetime.min

        if(minute.between?(0,10) || minute.between?(30,40))
          destination = "/RAs/Xavier/Target1"                 ###############TARGET 1###################
        else
          destination = "/RAs/Xavier/Target2"                 ###############TARGET 2###################
        end

        #targetData = client.metadata destination
        #data

        to_path = "#{destination}/#{newfilename}"
        response = client.file_move(from_path, to_path)
      end
    end

  end

end

