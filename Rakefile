require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'fileutils'
require 'rspec/core/rake_task'
require 'fpm'

desc "Create a debian package"
task :package do
  sh "mkdir -p build"
  sh "if [ `ls -1 build/ 2>/dev/null | wc -l` != 0 ]; then rm -r build/*; fi"
  sh "if [ -f *.deb ]; then rm *.deb; fi"
  hash = `git rev-parse --short HEAD`.chomp
  v_part= ENV['BUILD_NUMBER'] || "0.pre.#{hash}"
  version = "0.0.#{v_part}"
  sh "cp -r agent build"
  sh "fpm -s dir -t deb --architecture all -C build --name mcollective-plugins-actionservice --version #{version} --prefix /usr/share/mcollective/plugins/mcollective/"
end

desc "Create a debian package"
task :install => [:package] do
  sh "sudo dpkg -i *.deb"
  sh "sudo /etc/init.d/mcollective restart;"
end
