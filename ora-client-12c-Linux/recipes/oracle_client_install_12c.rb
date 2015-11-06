#
# Author: Gowrish.Mallipattana
#
# Oracle client installation recipe
#
#

require 'etc'

# Variables set for use by templates and others

responseFile='/tmp/oracle_client_12c_unix.rsp'
softwareFolder=node[:softwareFolder]
softwareBundle=node[:ora_client12c][:softwareBundle]
softwareCopy=/tmp/#{softwareBundle}
unzipDir='/tmp/oracle_client_unzip'
runInstaller='#{unzipDir}/client/runInstaller'

# Create the response file from template
#template '/tmp/oracle_client_12c_unix.rsp' do
template '#{responseFile}' do
  source 'oracle_client_12c_unix_rsp.erb'
   owner 'oracle'
   group 'oinstall'
    mode '0755'
    variables({
     :installGroup  => node[:oracle][:installGroup],
     :installUser   => node[:ora_client12c][:installUser],
     :oraInventory  => node[:oracle][:oraInventory],
     :oraBase       => node[:oracle][:oraBase],
     :oraHome       => node[:ora_client12c][:oraHome],
     :installType   => node[:ora_client12c][:installType],
     :hostname      => node[:hostname]
  })
end

 
# Unzip the software zip and run the runInstaller
execute 'copy unzip install oracle software bundle' do

  ##{node[:softwareFolder]/node[:ora_client12c][:softwareBundle]'}
  #command "cp #{softwareFolder}/#{softwareBundle} /tmp/" 
  ##creates #{softwareCopy}

  #command "mkdir /tmp/oracle_client_unzip"
  command "su - oracle -c 'mkdir #{unzipDir}' "
  command "su - oracle -c 'unzip #{softwareFolder}/#{softwareBundle} -d #{unzipDir}' "

  command "su - oracle -c '#{runInstaller} -silent -noconfig -responseFile #{responseFile}' "

  end

#execute 'install oracle software' do

#/directory_path/runInstaller [-silent] [-noconfig]  -responseFile responsefilename

#end
