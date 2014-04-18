namespace :deploy do
  namespace :assets do
    Rake::Task['deploy:assets:precompile'].clear_actions

    desc "Precompile assets on local machine and upload them to the server."
    task :precompile do
      run_locally do
        execute 'RAILS_ENV=production bundle exec rake assets:precompile'
      end

      on roles(:app) do
        within release_path do
          asset_full_path = "#{release_path}/public/#{fetch(:assets_prefix)}"
          asset_parent_path = File.dirname(asset_full_path)
          execute "mkdir -p #{asset_full_path}"
          upload! "./public/#{fetch(:assets_prefix)}", asset_parent_path, recursive: true
        end
      end

      run_locally do
        execute "rm -r ./public/#{fetch(:assets_prefix)}"
      end
    end
  end
end
