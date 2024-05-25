# E.g. 1
# recipe for creation of file
file "/myfile" do
content "My first chef recipe"
action :create
owner :root
group :root
mode :0755
end

# E.g. 2
# recipe for installation of package
package "tree" do
action :install
end
# starting the http service
service 'httpd' do
    action [:start, :enable]
end

# E.g.3 
# Create a group
group 'devops' do
    action :Create
end

#create a user and add it to the group
user 'mayur' do
    comment 'Mayur Goraksha Gaikwad'
    uid '1234'
    home '/home/mayur'
    shell '/bin/bash'
    action :create
end

#E.g.4
# Use a template for configuration file
template '/etc/httpd/conf/httpd.conf' do
    source 'httpd.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[httpd]', :immediately
  end
  
  # Ensure the service is enabled and started
  service 'httpd' do
    action [:enable, :start]
  end


#E.g.5
# Create a appication directory

directory '/opt/myapp' do
    owner 'mayur'
    group 'devops'
    mode '0755'
    action :create
end

# Deploy application code
cookbook_file '/opt/myapp/app.py' do
    source 'app.py'
    owner 'mayur'
    group 'devops'
    mode  '0755'
    action :create
end








# Attributes for customization

node.default['myapp']['port'] = 8080

#using attributes in the recipe
template '/etc/mayapp/config.yml' do
    source 'config.yml.erb'
    variables({
        port: node['myapp']['port']
    })
    owner 'mayur'
    group 'devops'
    mode '0644'
    action :create
end