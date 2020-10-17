# Purple Dobie Blog

This is a demonstration app for Snyk. It is a Ruby based app that runs in a container and can be deployed to Kubernetes.

## Gooder and Badder versions of the app

There are two "versions" of this app:

### _Badder_
The default version of this app is called `badder`. It has many vulnerabilities in the code, container, and basically no security configured in the Kubernetes deployment.

### _Gooder_
The cleaner version of this app is called `gooder`. The high sev Ruby issues are fixed, the Dockerfile uses a better base image, and the Kubernetes YAML has several security configs added.

### Pick your version.
When you first clone this repository you _should_ be running the `badder` version but you can easily switch back and forth using the `badder.sh` and `gooder.sh` scripts:

```bash
# switch to 'badder'
./badder.sh

# switch to 'gooder':
./gooder.sh
```

The scripts simply copy the requisite files from the .orig directory.

---
## Recommended way to run

1. Get [Tilt](https://docs.tilt.dev/install.html)
1. Get Docker Desktop and enable Kubernetes
1. [Setup Snyk Container](https://support.snyk.io/hc/en-us/articles/360003916138-Kubernetes-integration-overview) to monitor Kube workloads
1. `tilt up`
1. Switch between _badder_ and _gooder_ versions of the app:
   * Run `./badder.sh` to go to the bad version
   * Run `./gooder.sh` to go to the cleaner version
   * _tilt_ will take care of building the image and running it in the Kube cluster in Docker Desktop

---

## Running manually
If you don't want to use Tilt this method will work. But you should use Tilt. :) 


### Building the containers
You can build the container images for each demo using Docker. The Kube deployment file is expecting an image `purpledobie/blog:demo`.

To build the `badder` image:
```
# make sure you have the badder files:
./badder.sh

# build
docker build -t purpledobie/blog:demo .
```
To build the `gooder` image:
```
# make sure you have the gooder files:
./gooder.sh

# build
docker build -t purpledobie/blog:demo .
```
Both images look for an intermediate image named `purpledobie/blog:gems-[good | bad]. These images are already built and stored on Docker Hub so you shouldn't need to do anything else...but if you have any issues accessing those images, you can re-build as follows:

```bash
### badder version
# make sure you have the badder files:
./badder.sh

# build
docker build -t purpledobie/blog:gems-bad . -f .orig/badder.gems.Dockerfile



### gooder version
# make sure you have the badder files:
./gooder.sh

# build
docker build -t purpledobie/blog:gems-good . -f .orig/gooder.gems.Dockerfile
```

### 