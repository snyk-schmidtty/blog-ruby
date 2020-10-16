# For this demo there are two versions of the app: 'badder' and 'gooder'
#    badder: many vulns in the code, container, and weak K8s config yaml
#    gooder: fewer vulns everywhere and stronger K8s yaml
# 
# The files that control the version are in the .orig directory
#    badder: all files named with orig.*
#    gooder: all files named gooder.*
# 
# The badder.sh and gooder.sh scripts will copy the appropriate files to our main directory
# and Tilt should handle all the rest for us! When Tilt finishes there should be a new image,
# and a refreshed deployment

docker_build('purpledobie/blog:demo','.')
k8s_yaml('deployment.yaml')

k8s_resource('blog', port_forwards=3000)

