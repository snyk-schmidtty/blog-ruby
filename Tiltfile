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

def snyk(name, path, test_type, *dfile, **kwargs):
    """
    Args:
      name: the name of this tilt resource (what you'll see in Tilt's sidebar)
      path: path to file to test
            for container: path is the image name and tag
            for iac: the name of the file to test
            for oss: path to search. oss uses '--all-projects' by default right now
      test_type: one of 'container', 'iac', or 'oss'. Determines which test to run.
      dfile: (optional) the Dockerfile to test with a container test
    """        

    if test_type == 'iac':
        snyk_test_cmd = " ".join([
            "snyk",
            test_type,
            "test",
            path
        ])
        local_resource(
          name,
          deps=[path],
          cmd= snyk_test_cmd
        )

    elif test_type == 'container':
        snyk_test_cmd = " ".join([
            "snyk",
            test_type,
            "test",
            path,
            "--file=" + dfile[0]  
        ])
        local_resource(
            name,
            deps=[path],
            cmd= snyk_test_cmd  
        )

    elif test_type == 'oss':
        snyk_test_cmd = " ".join([
            "snyk",
            "test",
            path,
            "--all-projects"
        ])
        local_resource(
            name,
            deps=[path],
            cmd= snyk_test_cmd  
        )



docker_build('purpledobie/blog:demo','.')
snyk('snyk-cnr','purpledobie/blog:demo','container','Dockerfile')
k8s_yaml('deployment.yaml')
snyk('snyk-iac','deployment.yaml','iac')

k8s_resource('blog', port_forwards=3000)


