# Cloud Computing


```
docker buildx build -t sftp sftp

mkdir key
docker run -p 22:22 -d -v key/:/home/alunno/ sftp

gcloud auth activate-service-account <sa-email> --key-file=<sa-key> --project itis-441214

export GOOGLE_APPLICATION_CREDENTIALS=<sa-key>

gcloud container clusters get-credentials itis --zone europe-west12-a
```

