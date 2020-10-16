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

## Building the containers
You can build the container images for each demo using Docker. The deployment file is expecting an image `purpledobie/blog:latest` for the `badder` version and `purpledobie/blog:fixed` for the `gooder` version.

To build the `badder` image:
```
# make sure you have the badder files:
./badder.sh

# build
docker build -t purpledobie/blog:latest .
```
To build the `gooder` image:
```
# make sure you have the gooder files:
./gooder.sh

# build
docker build -t purpledobie/blog:fixed .
```
