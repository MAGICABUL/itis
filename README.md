# Cloud Computing


```
docker buildx build -t sftp sftp

mkdir key
docker run -p 22:22 -d -v key/:/home/alunno/ sftp

gcloud auth activate-service-account <sa-email> --key-file=<sa-key> --project itis-441214

gcloud container clusters get-credentials itis --zone europe-west12-a
```


```
printf '%s\n' {0..15} | xargs -I {} scp ./alunno-{}.json alunno@<ip>:/key/
```

