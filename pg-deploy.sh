echo '-------Deploy a PostgreSQL sample database'

kubectl create namespace yong-postgresql
helm3 repo add bitnami https://charts.bitnami.com/bitnami
helm3 repo update
helm3 install --namespace yong-postgresql postgres bitnami/postgresql --set primary.persistence.size=20Gi
