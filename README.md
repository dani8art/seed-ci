# Seed CircleCI

## INSTALL seed-circleci

```console
export COMMON_FIELDS=circleci,release.enabled=true,deployment.enabled=true
export DEPLOYMENT_S3=deployment.type=s3,deployment.s3.bucket=templates,deployment.s3.files[0]=seed.yaml
export DEPLOYMENT_DOCKER=deployment.docker.image=darteaga/seed-circleci,deployment.docker.additionalTags[0]=latest

seeder plant -f \
  --set artifact=$COMMON_FIELDS,$DEPLOYMENT_S3,$DEPLOYMENT_DOCKER circleci && \
  chmod +x .circleci/skip-when-release .circleci/chart-upgrade-app
```
