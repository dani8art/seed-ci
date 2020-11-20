# Seed CircleCI

## INSTALL seed-circleci

```console
seeder plant -f \
  --set artifact=circleci,release.enabled=true,deployment.enabled=true,deployment.type=s3,deployment.s3.bucket=templates,deployment.s3.files[0]=seed.yaml circleci && \
  chmod +x .circleci/skip-when-release
```
