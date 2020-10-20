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

load('ext://snyk', 'snyk')

image_name = 'purpledobie/blog:demo' # The name of the image to be built (has to match k8s deploy spec)
deploy_file = 'deployment.yaml'      # The name of the K8s YAML to apply
docker_file = 'Dockerfile'       # Dockerfile incl path
kube_selector = 'blog'          # Name Tilt uses for the k8s resource (has to match name from k8s deploy spec)


docker_build(image_name,'.')
k8s_yaml(deploy_file)
k8s_resource(kube_selector, port_forwards=3000)

# Do our testing - the tests run automatically the first time; subsequent tests are manual (click the refresh button in Tilt UI)
container_opts = "".join([
    "--file=",
    docker_file,
    " --severity-threshold=medium"
])

iac_opts = " --severity-threshold=medium"

snyk(image_name, 'container', 'snyk-cnr', kube_selector, container_opts)
snyk(deploy_file, 'iac', 'snyk-iac', '', iac_opts)

