namespace :deploy do
  namespace :assets do
    Rake::Task['deploy:assets:precompile'].clear_actions

    set :asset_full_path, -> { "#{release_path}/public/#{fetch(:assets_prefix)}" }

    task :precompile_on_local do
      run_locally do
        execute 'RAILS_ENV=production bundle exec rake assets:precompile'
        execute "cd ./public/#{fetch(:assets_prefix)} && tar zcf assets.tar.gz *"
      end
    end

    task :upload_and_extract do
      on roles(:app) do
        within release_path do
          execute "mkdir -p #{fetch(:asset_full_path)}"
          upload! "./public/#{fetch(:assets_prefix)}/assets.tar.gz", fetch(:asset_full_path)
          execute "cd #{fetch(:asset_full_path)} && tar zxf assets.tar.gz"
          execute "cd #{fetch(:asset_full_path)} && rm assets.tar.gz"
        end
      end
    end

    task :clean do
      run_locally do
        execute "rm -r ./public/#{fetch(:assets_prefix)}"
      end
    end

    desc "Precompile assets on local machine and upload them to the server."
    task :precompile do
      begin
        invoke 'deploy:assets:precompile_on_local'
        invoke 'deploy:assets:upload_and_extract'
      ensure
        invoke 'deploy:assets:clean'
      end
    end
  end
end
