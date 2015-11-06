#
# Author: Gowrish.Mallipattana
#
# Oracle client installation recipe
#
#

# Variables set for use by templates and others

# Create the response file from template

responseFile=/tmp/oracle_client_12c_unix.rsp

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


# Unzip the software zip 
#{node[:softwareFolder]/node[:ora_client12c][:softwareBundle]'}
softwareFolder=node[:softwareFolder]
softwareBundle=node[:ora_client12c][:softwareBundle]
softwareCopy=/tmp/#{softwareBundle}

execute 'copy and unzip oracle software bundle' do

  #command "cp #{softwareFolder}/#{softwareBundle} /tmp/" 
  ##creates #{softwareCopy}

  command "mkdir /tmp/oracle_client12c"
  command "unzip #{softwareFolder}/#{softwareBundle} -d /tmp/oracle_clientc"

end

#execute 'install oracle software' do

#/directory_path/runInstaller [-silent] [-noconfig]  -responseFile responsefilename

#end
